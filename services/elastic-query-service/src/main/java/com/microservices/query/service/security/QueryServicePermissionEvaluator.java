package com.microservices.query.service.security;

import com.microservices.query.service.model.ElasticQueryServiceAnalyticsResponseModel;
import com.microservices.query.service.model.ElasticQueryServiceRequestModel;
import com.microservices.query.service.model.ElasticQueryServiceResponseModel;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.PermissionEvaluator;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.List;
import java.util.Objects;

@Component
public class QueryServicePermissionEvaluator implements PermissionEvaluator {

    private static final String SUPER_USER_ROLE = "APP_SUPER_USER_ROLE";
    private final HttpServletRequest httpServletRequest;

    public QueryServicePermissionEvaluator(HttpServletRequest request) {
        this.httpServletRequest = request;
    }


    @Override
    public boolean hasPermission(Authentication authentication,
                                 Object targetDomain,
                                 Object permission) {


        /*
        0) if superUser return always true
        1) If the target domain object is a request object, then we need
        to handle it through preauthorize
        2) If the target domain is responseEntity we are returning from controller,
        so we should handle it through postAuthorize
         */
        if (isSuperUser()) {
            return true;
        }
        if (targetDomain instanceof ElasticQueryServiceRequestModel) {
            return preAuthorize(authentication, ((ElasticQueryServiceRequestModel) targetDomain).getId(), permission);
        } else if (targetDomain instanceof ResponseEntity || targetDomain == null) {
            if (targetDomain == null) {
                return true;
            }
            ElasticQueryServiceAnalyticsResponseModel responseBody =
                    ((ResponseEntity<ElasticQueryServiceAnalyticsResponseModel>) targetDomain).getBody();
            Objects.requireNonNull(responseBody);
            return postAuthorize(authentication, responseBody.getQueryResponseModels(), permission);
        }
        return false;
    }

    @Override
    public boolean hasPermission(Authentication authentication,
                                 Serializable targetId,
                                 String targetType,
                                 Object permission) {
        if(targetId == null)
            return false;

        return preAuthorize(authentication, (String) targetId, permission);
    }

    private boolean hasPermission(String requiredPermission, PermissionType userPermission) {
        return userPermission != null && requiredPermission.equals(userPermission.getType());
    }

    /*
    We iterate all response model objects and check if user's permission to the returned object,
    to do the defined permission, which is always READ in our case, as this is a query service.
    SO we expect that user has permission to all documents queried, otherwise we don't return the response.
     */
    private boolean postAuthorize(Authentication authentication,
                                  List<ElasticQueryServiceResponseModel> responseBody,
                                  Object permission) {
        TwitterQueryUser twitterQueryUser = (TwitterQueryUser) authentication.getPrincipal();
        for (ElasticQueryServiceResponseModel responseModel : responseBody) {
            PermissionType userPermission = twitterQueryUser.getPermissions().get(responseModel.getId());
            if (!hasPermission((String) permission, userPermission)) {
                return false;
            }
        }
        return true;
    }



    private boolean preAuthorize(Authentication authentication, String id, Object permission) {
        TwitterQueryUser twitterQueryUser = (TwitterQueryUser) authentication.getPrincipal();
        PermissionType userPermission = twitterQueryUser.getPermissions().get(id);
        return hasPermission((String) permission, userPermission);
    }

    /*
    We use isUserInRole method in this class which is like calling hasRole
    method inside preAuthorize annotation
     */
    private boolean isSuperUser() {
        return httpServletRequest.isUserInRole(SUPER_USER_ROLE);
    }
}
