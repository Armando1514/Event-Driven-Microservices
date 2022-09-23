package com.microservices.analytics.service.dataaccess.repository;

import java.util.Collection;

/**
 * Spring Data Customized CRUD Repository for entity.
 *
 * @param <T>
 */
public interface AnalyticsCustomRepository<T, PK> {

    <S extends T> PK persist(S entity);

    <S extends T> void batchPersist(Collection<S> entities);

    <S extends T> S merge(S entity);

    <S extends T> void batchMerge(Collection<S> entities);

    void clear();
}
