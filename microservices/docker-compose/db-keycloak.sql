--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.4

-- Started on 2022-09-19 17:23:59 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;



\connect keycloak

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16385)
-- Name: keycloak; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA keycloak;


ALTER SCHEMA keycloak OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16386)
-- Name: admin_event_entity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE keycloak.admin_event_entity OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16391)
-- Name: associated_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.associated_policy OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16394)
-- Name: authentication_execution; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE keycloak.authentication_execution OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16398)
-- Name: authentication_flow; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.authentication_flow OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16406)
-- Name: authenticator_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.authenticator_config OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16409)
-- Name: authenticator_config_entry; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16414)
-- Name: broker_link; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE keycloak.broker_link OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16419)
-- Name: client; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16437)
-- Name: client_attributes; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_attributes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16442)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16445)
-- Name: client_initial_access; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE keycloak.client_initial_access OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16448)
-- Name: client_node_registrations; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_node_registrations OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16451)
-- Name: client_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE keycloak.client_scope OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16456)
-- Name: client_scope_attributes; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16461)
-- Name: client_scope_client; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client_scope_client OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16467)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16470)
-- Name: client_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE keycloak.client_session OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16475)
-- Name: client_session_auth_status; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_auth_status OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16478)
-- Name: client_session_note; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_note OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16483)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_prot_mapper OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16486)
-- Name: client_session_role; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_role OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16489)
-- Name: client_user_session_note; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_user_session_note OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16494)
-- Name: component; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE keycloak.component OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16499)
-- Name: component_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE keycloak.component_config OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16504)
-- Name: composite_role; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE keycloak.composite_role OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16507)
-- Name: credential; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.credential OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16512)
-- Name: databasechangelog; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE keycloak.databasechangelog OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16517)
-- Name: databasechangeloglock; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE keycloak.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16520)
-- Name: default_client_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.default_client_scope OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16524)
-- Name: event_entity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE keycloak.event_entity OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16529)
-- Name: fed_user_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE keycloak.fed_user_attribute OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16534)
-- Name: fed_user_consent; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.fed_user_consent OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16539)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16542)
-- Name: fed_user_credential; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.fed_user_credential OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16547)
-- Name: fed_user_group_membership; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_group_membership OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16550)
-- Name: fed_user_required_action; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_required_action OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16556)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_role_mapping OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16559)
-- Name: federated_identity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_identity OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16564)
-- Name: federated_user; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_user OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16569)
-- Name: group_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_attribute OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16575)
-- Name: group_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_role_mapping OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16578)
-- Name: identity_provider; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.identity_provider OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16589)
-- Name: identity_provider_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.identity_provider_config OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16594)
-- Name: identity_provider_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.identity_provider_mapper OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16599)
-- Name: idp_mapper_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16604)
-- Name: keycloak_group; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE keycloak.keycloak_group OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 16607)
-- Name: keycloak_role; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE keycloak.keycloak_role OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 16613)
-- Name: migration_model; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.migration_model OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 16617)
-- Name: offline_client_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE keycloak.offline_client_session OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 16624)
-- Name: offline_user_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.offline_user_session OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 16630)
-- Name: policy_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.policy_config OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 16635)
-- Name: protocol_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE keycloak.protocol_mapper OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 16640)
-- Name: protocol_mapper_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 16645)
-- Name: realm; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE keycloak.realm OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 16678)
-- Name: realm_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE keycloak.realm_attribute OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 16683)
-- Name: realm_default_groups; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_default_groups OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 16686)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 16689)
-- Name: realm_events_listeners; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 16692)
-- Name: realm_localizations; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE keycloak.realm_localizations OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 16697)
-- Name: realm_required_credential; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_required_credential OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 16704)
-- Name: realm_smtp_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 16709)
-- Name: realm_supported_locales; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 16712)
-- Name: redirect_uris; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.redirect_uris OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 16715)
-- Name: required_action_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.required_action_config OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 16720)
-- Name: required_action_provider; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE keycloak.required_action_provider OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 16727)
-- Name: resource_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_attribute OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 16733)
-- Name: resource_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_policy OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 16736)
-- Name: resource_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_scope OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 16739)
-- Name: resource_server; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE keycloak.resource_server OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 16744)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE keycloak.resource_server_perm_ticket OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 16749)
-- Name: resource_server_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE keycloak.resource_server_policy OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 16754)
-- Name: resource_server_resource; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_resource OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 16760)
-- Name: resource_server_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_scope OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 16765)
-- Name: resource_uris; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.resource_uris OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 16768)
-- Name: role_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE keycloak.role_attribute OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 16773)
-- Name: scope_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_mapping OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 16776)
-- Name: scope_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_policy OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 16779)
-- Name: user_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE keycloak.user_attribute OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 16785)
-- Name: user_consent; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.user_consent OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 16790)
-- Name: user_consent_client_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 16793)
-- Name: user_entity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.user_entity OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 16801)
-- Name: user_federation_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_config OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 16806)
-- Name: user_federation_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 16811)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 16816)
-- Name: user_federation_provider; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.user_federation_provider OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 16821)
-- Name: user_group_membership; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_group_membership OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 16824)
-- Name: user_required_action; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE keycloak.user_required_action OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 16828)
-- Name: user_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_role_mapping OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 16831)
-- Name: user_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE keycloak.user_session OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 16837)
-- Name: user_session_note; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE keycloak.user_session_note OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 16842)
-- Name: username_login_failure; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE keycloak.username_login_failure OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 16847)
-- Name: web_origins; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.web_origins OWNER TO postgres;

--
-- TOC entry 4111 (class 0 OID 16386)
-- Dependencies: 210
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4112 (class 0 OID 16391)
-- Dependencies: 211
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4113 (class 0 OID 16394)
-- Dependencies: 212
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9eee803f-d3da-42df-9811-db6da46335d1', NULL, 'auth-cookie', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '58bc45ed-df13-45ee-82a2-a5b2c616b1ee', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3f30d84d-e14c-4741-a278-aa9d81d6af98', NULL, 'auth-spnego', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '58bc45ed-df13-45ee-82a2-a5b2c616b1ee', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7ec8f128-13ec-4f5a-89a4-b8b813b68028', NULL, 'identity-provider-redirector', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '58bc45ed-df13-45ee-82a2-a5b2c616b1ee', 2, 25, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d5ab3f03-f88f-4146-8afe-8c81a336775a', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '58bc45ed-df13-45ee-82a2-a5b2c616b1ee', 2, 30, true, 'da4c2ca1-6275-4d91-86a4-845d66459cc3', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5178b66d-2815-4a18-b1d7-76ca5f838002', NULL, 'auth-username-password-form', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'da4c2ca1-6275-4d91-86a4-845d66459cc3', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ccbe4773-10a1-41ec-8855-6fba214c7f8c', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'da4c2ca1-6275-4d91-86a4-845d66459cc3', 1, 20, true, 'd68dc7b0-7a03-4fa0-b6d0-5a7fc9029998', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1facef6e-c093-493c-be8b-22b9faf6b997', NULL, 'conditional-user-configured', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'd68dc7b0-7a03-4fa0-b6d0-5a7fc9029998', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('aa4538a5-0fee-4869-9d07-a25389bb2934', NULL, 'auth-otp-form', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'd68dc7b0-7a03-4fa0-b6d0-5a7fc9029998', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('83d766d3-6a9a-4faa-b828-5b7c9d24f38d', NULL, 'direct-grant-validate-username', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '836b06ea-d04a-48fa-8a53-e41fcb909a3a', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('61deb70d-1f44-40f0-9b49-39f6394520c9', NULL, 'direct-grant-validate-password', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '836b06ea-d04a-48fa-8a53-e41fcb909a3a', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1065d4b3-4a1c-4234-9a22-a46340d7422a', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '836b06ea-d04a-48fa-8a53-e41fcb909a3a', 1, 30, true, '6b0d9ca4-35b0-45d5-b72a-9d64fb80cb5e', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5598a55e-e4d4-493a-bf55-7ed8b7c56517', NULL, 'conditional-user-configured', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '6b0d9ca4-35b0-45d5-b72a-9d64fb80cb5e', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('25685f88-f337-4721-b8bf-11d653c2e04d', NULL, 'direct-grant-validate-otp', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '6b0d9ca4-35b0-45d5-b72a-9d64fb80cb5e', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('52cfd867-6ce9-4782-8e80-0904fbbfcf49', NULL, 'registration-page-form', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'da7df9ba-95ff-4dd8-bde5-9e644adac25c', 0, 10, true, 'f9137292-0f54-4e13-b57f-cf576dfbe26c', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('50739f16-0359-44e2-b05b-61a98b845c05', NULL, 'registration-user-creation', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'f9137292-0f54-4e13-b57f-cf576dfbe26c', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d2e59dea-07a8-4f10-b375-56f4bedad1ff', NULL, 'registration-profile-action', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'f9137292-0f54-4e13-b57f-cf576dfbe26c', 0, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2aae0df9-2b26-47c4-bf99-d110dc1e57e0', NULL, 'registration-password-action', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'f9137292-0f54-4e13-b57f-cf576dfbe26c', 0, 50, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7ea90ecb-139c-4b19-9578-884369e48546', NULL, 'registration-recaptcha-action', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'f9137292-0f54-4e13-b57f-cf576dfbe26c', 3, 60, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f3b5ba58-500e-4a25-bc85-db193174ef88', NULL, 'reset-credentials-choose-user', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'efabb7a9-096a-4c4c-a32c-1f1ac70d7f81', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('eaba04b2-6f73-4fd7-9ddb-e8bb3e6ac947', NULL, 'reset-credential-email', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'efabb7a9-096a-4c4c-a32c-1f1ac70d7f81', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('312f0a5c-1ab4-4075-86fa-c37a68d5f165', NULL, 'reset-password', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'efabb7a9-096a-4c4c-a32c-1f1ac70d7f81', 0, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('239291d1-5acc-446a-aedb-30485bef47e6', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'efabb7a9-096a-4c4c-a32c-1f1ac70d7f81', 1, 40, true, '05a65aa4-9a45-440d-8521-6cb8f8ac76f2', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7dabbcbc-0c96-450b-83f9-effcd2a53b77', NULL, 'conditional-user-configured', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '05a65aa4-9a45-440d-8521-6cb8f8ac76f2', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('35da2ede-61f6-4837-8ff6-368b74f53f10', NULL, 'reset-otp', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '05a65aa4-9a45-440d-8521-6cb8f8ac76f2', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1a63a447-3c00-4fe3-b269-8db63598d35b', NULL, 'client-secret', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '09ae8333-b150-47c5-9d3a-3a7a94fcd937', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('44951396-e0c2-47e7-a1b4-e8f3e9728710', NULL, 'client-jwt', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '09ae8333-b150-47c5-9d3a-3a7a94fcd937', 2, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('66317f3a-f160-467a-8da3-0ff95e3276cd', NULL, 'client-secret-jwt', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '09ae8333-b150-47c5-9d3a-3a7a94fcd937', 2, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('eea60892-a902-4894-8666-0fd4ee946af4', NULL, 'client-x509', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '09ae8333-b150-47c5-9d3a-3a7a94fcd937', 2, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e6f6b26c-89d9-4ad5-a8b0-904d7c91e749', NULL, 'idp-review-profile', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '92a585e3-f9d0-47fe-87c1-b3172971ed3b', 0, 10, false, NULL, '3616aeec-bf44-4ef9-9210-2030a1e979ee');
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e2fbdc2a-6741-4940-9eb7-7961e1274d1a', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '92a585e3-f9d0-47fe-87c1-b3172971ed3b', 0, 20, true, '3ab0c835-fcae-4cfb-98af-51dd482760d6', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('09740531-b15c-4b1e-933a-5fccf13ba5a5', NULL, 'idp-create-user-if-unique', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '3ab0c835-fcae-4cfb-98af-51dd482760d6', 2, 10, false, NULL, '4fbf3ecd-2881-49ac-9121-5e7be7548763');
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ff921ed1-b080-4e1a-bf12-d605b0457e54', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '3ab0c835-fcae-4cfb-98af-51dd482760d6', 2, 20, true, 'bcf09f46-cc38-455c-ae9c-9b9d3d0765f4', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0147f139-c8d7-4dae-a976-702aa0329551', NULL, 'idp-confirm-link', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'bcf09f46-cc38-455c-ae9c-9b9d3d0765f4', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8022c3ea-4617-4916-9faf-3ce0c783e8cd', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'bcf09f46-cc38-455c-ae9c-9b9d3d0765f4', 0, 20, true, '9d24c7a7-c5bf-4754-850c-2c539d7e6ab1', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3db3160b-08f1-4849-af25-1846cbf782e8', NULL, 'idp-email-verification', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9d24c7a7-c5bf-4754-850c-2c539d7e6ab1', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5b9d135f-667d-414f-9d6d-f9d57c0a7db3', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9d24c7a7-c5bf-4754-850c-2c539d7e6ab1', 2, 20, true, '46c90bfe-2415-4db4-a766-aadd15cdd988', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('63afb458-a649-42be-8c17-5c4692680aab', NULL, 'idp-username-password-form', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '46c90bfe-2415-4db4-a766-aadd15cdd988', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e7643cae-4ca7-4e56-a4ae-2951282215e8', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '46c90bfe-2415-4db4-a766-aadd15cdd988', 1, 20, true, 'cfe7a2a3-0120-445f-8e87-611427779c84', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('72333366-17ca-45cf-90a3-eea917465d7c', NULL, 'conditional-user-configured', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'cfe7a2a3-0120-445f-8e87-611427779c84', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d3adc034-012b-44fa-92d1-664b6194bee2', NULL, 'auth-otp-form', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'cfe7a2a3-0120-445f-8e87-611427779c84', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('66308315-0663-4341-8aef-b07d32bc595e', NULL, 'http-basic-authenticator', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '62851e24-9165-475e-85da-8875b8a71a69', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('41c8a3d7-b537-4304-9b6c-480cee749b03', NULL, 'docker-http-basic-authenticator', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '5777caec-18d6-427d-8fd3-e25f4c842fe2', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4c9a9ee1-f2eb-449b-9ed2-546a273e9249', NULL, 'no-cookie-redirect', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'c020f8bb-4588-47b5-b1b2-4ac77607ac57', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d0b286f5-af8f-47fa-bbec-bc1ac87c490f', NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'c020f8bb-4588-47b5-b1b2-4ac77607ac57', 0, 20, true, '23192571-27ae-48c1-9609-7228f35667b9', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('08f5a4b3-46ca-4293-ba92-b4a298480b76', NULL, 'basic-auth', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '23192571-27ae-48c1-9609-7228f35667b9', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a407215b-4689-4623-8e29-21566453f203', NULL, 'basic-auth-otp', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '23192571-27ae-48c1-9609-7228f35667b9', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('450f19d5-b177-4733-be2b-a731f54023a5', NULL, 'auth-spnego', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '23192571-27ae-48c1-9609-7228f35667b9', 3, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5ce3a65b-e712-49c4-90d3-3231d25f7afb', NULL, 'auth-cookie', '245617d4-22a0-4661-9450-5c17c04f2d8c', '4fdfe572-bcd5-4a09-aae6-0bf5fab07ff2', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2556fba2-3c24-43bd-9a39-48a8d721d09e', NULL, 'auth-spnego', '245617d4-22a0-4661-9450-5c17c04f2d8c', '4fdfe572-bcd5-4a09-aae6-0bf5fab07ff2', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('60edf6a6-8f61-41ea-9c7e-c932480b2b26', NULL, 'identity-provider-redirector', '245617d4-22a0-4661-9450-5c17c04f2d8c', '4fdfe572-bcd5-4a09-aae6-0bf5fab07ff2', 2, 25, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a98b8956-aded-48a5-959f-21f3556a3c20', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', '4fdfe572-bcd5-4a09-aae6-0bf5fab07ff2', 2, 30, true, '33fa4a82-c4e6-45ad-9666-941c7ec0bda0', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('414164a5-2e1b-4a5b-b9bd-9ad98f9005c7', NULL, 'auth-username-password-form', '245617d4-22a0-4661-9450-5c17c04f2d8c', '33fa4a82-c4e6-45ad-9666-941c7ec0bda0', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fbe163c8-a678-42bd-8846-5d8628881afd', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', '33fa4a82-c4e6-45ad-9666-941c7ec0bda0', 1, 20, true, 'c6f0ee71-8885-4adb-b76b-bb6f8a745f5a', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('637f0783-ad36-4c4f-87cc-d94ca90e1747', NULL, 'conditional-user-configured', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'c6f0ee71-8885-4adb-b76b-bb6f8a745f5a', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('93c8475f-a04b-4caf-bd72-ef4da5675ccf', NULL, 'auth-otp-form', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'c6f0ee71-8885-4adb-b76b-bb6f8a745f5a', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b9c44703-07e9-411f-b8da-a5f193c3ba57', NULL, 'direct-grant-validate-username', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'f106394c-0c73-465c-a44a-a1d98446da2a', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5a5d6bd0-2d8e-4c6e-8d94-d11c7d430ab4', NULL, 'direct-grant-validate-password', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'f106394c-0c73-465c-a44a-a1d98446da2a', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('09716790-0681-4404-a631-4ae9a456748d', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'f106394c-0c73-465c-a44a-a1d98446da2a', 1, 30, true, 'f5f71008-682c-4600-a0d1-8f74d8356212', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('87f79a83-b1cd-44da-ba77-2f824ed878e5', NULL, 'conditional-user-configured', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'f5f71008-682c-4600-a0d1-8f74d8356212', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e2f32b8e-10da-4a92-bd5a-2646235caeb7', NULL, 'direct-grant-validate-otp', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'f5f71008-682c-4600-a0d1-8f74d8356212', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('573e1b02-fd60-4bc9-88b7-b85d7028e0bb', NULL, 'registration-page-form', '245617d4-22a0-4661-9450-5c17c04f2d8c', '1ffc15e4-906f-4487-aec9-6b42b90a3706', 0, 10, true, '759c33fa-d131-4e80-b8ea-7d7dd5a9be69', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9df573af-8317-49e2-88a4-97e946d65c1c', NULL, 'registration-user-creation', '245617d4-22a0-4661-9450-5c17c04f2d8c', '759c33fa-d131-4e80-b8ea-7d7dd5a9be69', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f9719c76-40af-4264-b3c5-8f399c6c090c', NULL, 'registration-profile-action', '245617d4-22a0-4661-9450-5c17c04f2d8c', '759c33fa-d131-4e80-b8ea-7d7dd5a9be69', 0, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f37cd0df-3511-407e-9a8b-da7170fa2922', NULL, 'registration-password-action', '245617d4-22a0-4661-9450-5c17c04f2d8c', '759c33fa-d131-4e80-b8ea-7d7dd5a9be69', 0, 50, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('28d8064d-e8d5-43c6-9f27-6d803e822aff', NULL, 'registration-recaptcha-action', '245617d4-22a0-4661-9450-5c17c04f2d8c', '759c33fa-d131-4e80-b8ea-7d7dd5a9be69', 3, 60, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7277979a-a4e1-4d80-ad4a-d02584ff4cea', NULL, 'reset-credentials-choose-user', '245617d4-22a0-4661-9450-5c17c04f2d8c', '859b567d-b871-4105-ac15-51e11fb4206d', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0bb3be12-a595-4463-a4a9-677e5d9c2364', NULL, 'reset-credential-email', '245617d4-22a0-4661-9450-5c17c04f2d8c', '859b567d-b871-4105-ac15-51e11fb4206d', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5667c2a5-9c8a-4576-9cb6-e48cdd10bae3', NULL, 'reset-password', '245617d4-22a0-4661-9450-5c17c04f2d8c', '859b567d-b871-4105-ac15-51e11fb4206d', 0, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cefe1ab5-50ac-436f-87c9-ff88c4693e74', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', '859b567d-b871-4105-ac15-51e11fb4206d', 1, 40, true, 'b94b513f-c207-4c0a-a9f0-e7bfae5e9c8c', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('99801c43-5db3-4ecc-b3e7-047a4f3e6b00', NULL, 'conditional-user-configured', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'b94b513f-c207-4c0a-a9f0-e7bfae5e9c8c', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4f32d52f-94da-4502-a78d-9adcc20b8f77', NULL, 'reset-otp', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'b94b513f-c207-4c0a-a9f0-e7bfae5e9c8c', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2202a855-9f0a-4ea4-811b-384c084bbc7d', NULL, 'client-secret', '245617d4-22a0-4661-9450-5c17c04f2d8c', '09b768c0-6bb3-4ab1-9a68-455bc3a215fe', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('68ca85b5-b93e-4fe2-bad0-ed46ddfff358', NULL, 'client-jwt', '245617d4-22a0-4661-9450-5c17c04f2d8c', '09b768c0-6bb3-4ab1-9a68-455bc3a215fe', 2, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e2f22301-ca9d-49d5-bc57-2b10c169600f', NULL, 'client-secret-jwt', '245617d4-22a0-4661-9450-5c17c04f2d8c', '09b768c0-6bb3-4ab1-9a68-455bc3a215fe', 2, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2e0c18f6-69c9-4132-bcb0-e606b6e605f4', NULL, 'client-x509', '245617d4-22a0-4661-9450-5c17c04f2d8c', '09b768c0-6bb3-4ab1-9a68-455bc3a215fe', 2, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('03a84256-0610-4b14-b035-9ae92d432d77', NULL, 'idp-review-profile', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'f4f5b4c1-0074-47aa-a413-ab69080fc7f3', 0, 10, false, NULL, 'a700b51c-1ce9-43e1-8e4d-aca3c1dd5df6');
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('69836404-6e2a-440b-bb27-99605c65a87b', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'f4f5b4c1-0074-47aa-a413-ab69080fc7f3', 0, 20, true, 'cb28a569-cdda-49cc-a7b7-00fe32eebf26', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b57b35cf-e728-4af1-9fa3-c989f55aabce', NULL, 'idp-create-user-if-unique', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'cb28a569-cdda-49cc-a7b7-00fe32eebf26', 2, 10, false, NULL, '8d4435c9-ddb9-470d-96c1-71d3281ceef8');
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9a896b88-1e20-4e39-bc05-5532f148ba74', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'cb28a569-cdda-49cc-a7b7-00fe32eebf26', 2, 20, true, 'ce31bac3-c21a-4b0f-ba5f-dad6354d1451', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('12e95a0f-8239-46a8-b7de-5045c6a5f728', NULL, 'idp-confirm-link', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'ce31bac3-c21a-4b0f-ba5f-dad6354d1451', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6599545a-9fb9-439c-9d90-f94ef5f91735', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'ce31bac3-c21a-4b0f-ba5f-dad6354d1451', 0, 20, true, '82abbbbb-d405-49a3-860c-58572631b9f9', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('507eff44-9f33-4c12-b9d4-9015f554d61c', NULL, 'idp-email-verification', '245617d4-22a0-4661-9450-5c17c04f2d8c', '82abbbbb-d405-49a3-860c-58572631b9f9', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a7cb6748-28ff-4f6f-bde1-dfb51797d1a7', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', '82abbbbb-d405-49a3-860c-58572631b9f9', 2, 20, true, 'd33e9fcb-44a4-4f36-9fcf-cd3bae1e8746', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0335ac28-3d75-4dae-ba94-7b96a9fea9aa', NULL, 'idp-username-password-form', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'd33e9fcb-44a4-4f36-9fcf-cd3bae1e8746', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b83e350b-b731-4261-9361-249a1170ec69', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'd33e9fcb-44a4-4f36-9fcf-cd3bae1e8746', 1, 20, true, '4edd42b3-b14a-4638-ae84-5632d1dc284f', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c59bd008-c777-4129-8b22-908545cb09ce', NULL, 'conditional-user-configured', '245617d4-22a0-4661-9450-5c17c04f2d8c', '4edd42b3-b14a-4638-ae84-5632d1dc284f', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('928b244d-9162-416e-9916-f2c819815e9c', NULL, 'auth-otp-form', '245617d4-22a0-4661-9450-5c17c04f2d8c', '4edd42b3-b14a-4638-ae84-5632d1dc284f', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b5836c28-746b-4671-880b-7267c9cf14d3', NULL, 'http-basic-authenticator', '245617d4-22a0-4661-9450-5c17c04f2d8c', '68350210-b820-488d-8d0f-6d90590304cf', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cf6ae181-8139-4f0e-b89c-835bac2d3ef8', NULL, 'docker-http-basic-authenticator', '245617d4-22a0-4661-9450-5c17c04f2d8c', '888aaa60-bab6-496e-a7d5-181118a4fb34', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c1ba21f7-5b7a-41f6-b3fd-532af2e975e3', NULL, 'no-cookie-redirect', '245617d4-22a0-4661-9450-5c17c04f2d8c', '069a3b9d-978c-4d2c-98c1-f52a32d493bb', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('249da49e-3345-4a1e-9d18-3e75d4629bac', NULL, NULL, '245617d4-22a0-4661-9450-5c17c04f2d8c', '069a3b9d-978c-4d2c-98c1-f52a32d493bb', 0, 20, true, '18a9f819-a2c5-43e7-bf87-cf5dcafa7900', NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d79faa0b-7f72-4bb1-abc4-d45337abea56', NULL, 'basic-auth', '245617d4-22a0-4661-9450-5c17c04f2d8c', '18a9f819-a2c5-43e7-bf87-cf5dcafa7900', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0d512b90-9170-4750-980c-bc13c1066d8a', NULL, 'basic-auth-otp', '245617d4-22a0-4661-9450-5c17c04f2d8c', '18a9f819-a2c5-43e7-bf87-cf5dcafa7900', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cfffbf2d-95c7-4984-88e4-44b3ad5e377e', NULL, 'auth-spnego', '245617d4-22a0-4661-9450-5c17c04f2d8c', '18a9f819-a2c5-43e7-bf87-cf5dcafa7900', 3, 30, false, NULL, NULL);


--
-- TOC entry 4114 (class 0 OID 16398)
-- Dependencies: 213
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('58bc45ed-df13-45ee-82a2-a5b2c616b1ee', 'browser', 'browser based authentication', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('da4c2ca1-6275-4d91-86a4-845d66459cc3', 'forms', 'Username, password, otp and other auth forms.', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d68dc7b0-7a03-4fa0-b6d0-5a7fc9029998', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('836b06ea-d04a-48fa-8a53-e41fcb909a3a', 'direct grant', 'OpenID Connect Resource Owner Grant', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('6b0d9ca4-35b0-45d5-b72a-9d64fb80cb5e', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('da7df9ba-95ff-4dd8-bde5-9e644adac25c', 'registration', 'registration flow', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f9137292-0f54-4e13-b57f-cf576dfbe26c', 'registration form', 'registration form', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'form-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('efabb7a9-096a-4c4c-a32c-1f1ac70d7f81', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('05a65aa4-9a45-440d-8521-6cb8f8ac76f2', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('09ae8333-b150-47c5-9d3a-3a7a94fcd937', 'clients', 'Base authentication for clients', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'client-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('92a585e3-f9d0-47fe-87c1-b3172971ed3b', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('3ab0c835-fcae-4cfb-98af-51dd482760d6', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('bcf09f46-cc38-455c-ae9c-9b9d3d0765f4', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9d24c7a7-c5bf-4754-850c-2c539d7e6ab1', 'Account verification options', 'Method with which to verity the existing account', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('46c90bfe-2415-4db4-a766-aadd15cdd988', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('cfe7a2a3-0120-445f-8e87-611427779c84', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('62851e24-9165-475e-85da-8875b8a71a69', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5777caec-18d6-427d-8fd3-e25f4c842fe2', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c020f8bb-4588-47b5-b1b2-4ac77607ac57', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('23192571-27ae-48c1-9609-7228f35667b9', 'Authentication Options', 'Authentication options.', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('4fdfe572-bcd5-4a09-aae6-0bf5fab07ff2', 'browser', 'browser based authentication', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('33fa4a82-c4e6-45ad-9666-941c7ec0bda0', 'forms', 'Username, password, otp and other auth forms.', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c6f0ee71-8885-4adb-b76b-bb6f8a745f5a', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f106394c-0c73-465c-a44a-a1d98446da2a', 'direct grant', 'OpenID Connect Resource Owner Grant', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f5f71008-682c-4600-a0d1-8f74d8356212', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('1ffc15e4-906f-4487-aec9-6b42b90a3706', 'registration', 'registration flow', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('759c33fa-d131-4e80-b8ea-7d7dd5a9be69', 'registration form', 'registration form', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'form-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('859b567d-b871-4105-ac15-51e11fb4206d', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('b94b513f-c207-4c0a-a9f0-e7bfae5e9c8c', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('09b768c0-6bb3-4ab1-9a68-455bc3a215fe', 'clients', 'Base authentication for clients', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'client-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f4f5b4c1-0074-47aa-a413-ab69080fc7f3', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('cb28a569-cdda-49cc-a7b7-00fe32eebf26', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('ce31bac3-c21a-4b0f-ba5f-dad6354d1451', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('82abbbbb-d405-49a3-860c-58572631b9f9', 'Account verification options', 'Method with which to verity the existing account', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d33e9fcb-44a4-4f36-9fcf-cd3bae1e8746', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('4edd42b3-b14a-4638-ae84-5632d1dc284f', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('68350210-b820-488d-8d0f-6d90590304cf', 'saml ecp', 'SAML ECP Profile Authentication Flow', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('888aaa60-bab6-496e-a7d5-181118a4fb34', 'docker auth', 'Used by Docker clients to authenticate against the IDP', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('069a3b9d-978c-4d2c-98c1-f52a32d493bb', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('18a9f819-a2c5-43e7-bf87-cf5dcafa7900', 'Authentication Options', 'Authentication options.', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'basic-flow', false, true);


--
-- TOC entry 4115 (class 0 OID 16406)
-- Dependencies: 214
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.authenticator_config (id, alias, realm_id) VALUES ('3616aeec-bf44-4ef9-9210-2030a1e979ee', 'review profile config', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8');
INSERT INTO keycloak.authenticator_config (id, alias, realm_id) VALUES ('4fbf3ecd-2881-49ac-9121-5e7be7548763', 'create unique user config', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8');
INSERT INTO keycloak.authenticator_config (id, alias, realm_id) VALUES ('a700b51c-1ce9-43e1-8e4d-aca3c1dd5df6', 'review profile config', '245617d4-22a0-4661-9450-5c17c04f2d8c');
INSERT INTO keycloak.authenticator_config (id, alias, realm_id) VALUES ('8d4435c9-ddb9-470d-96c1-71d3281ceef8', 'create unique user config', '245617d4-22a0-4661-9450-5c17c04f2d8c');


--
-- TOC entry 4116 (class 0 OID 16409)
-- Dependencies: 215
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.authenticator_config_entry (authenticator_id, value, name) VALUES ('3616aeec-bf44-4ef9-9210-2030a1e979ee', 'missing', 'update.profile.on.first.login');
INSERT INTO keycloak.authenticator_config_entry (authenticator_id, value, name) VALUES ('4fbf3ecd-2881-49ac-9121-5e7be7548763', 'false', 'require.password.update.after.registration');
INSERT INTO keycloak.authenticator_config_entry (authenticator_id, value, name) VALUES ('8d4435c9-ddb9-470d-96c1-71d3281ceef8', 'false', 'require.password.update.after.registration');
INSERT INTO keycloak.authenticator_config_entry (authenticator_id, value, name) VALUES ('a700b51c-1ce9-43e1-8e4d-aca3c1dd5df6', 'missing', 'update.profile.on.first.login');


--
-- TOC entry 4117 (class 0 OID 16414)
-- Dependencies: 216
-- Data for Name: broker_link; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4118 (class 0 OID 16419)
-- Dependencies: 217
-- Data for Name: client; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('2326b487-7891-4716-9252-e03347239b67', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', true, false, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('dd051d59-5352-4d43-9481-0d66c8f4f718', true, false, 'microservices_realm-realm', 0, false, NULL, NULL, true, NULL, false, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL, 0, false, false, 'microservices_realm Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL, false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', true, false, 'account', 0, true, NULL, '/realms/microservices_realm/account/', false, NULL, false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', true, false, 'account-console', 0, true, NULL, '/realms/microservices_realm/account/', false, NULL, false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', true, false, 'security-admin-console', 0, true, NULL, '/admin/microservices_realm/console/', false, NULL, false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', true, true, 'elastic-query-web-client', 0, false, '8iYqVnAFHNQK6V9Nldn32nVdWQbl0b5t', 'http://elastic-query-web-client-1:8184/elastic-query-web-client', false, '', false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', -1, true, false, '', false, 'client-secret', '', '', NULL, true, false, true, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', true, true, 'elastic-query-service-1', 0, false, 'lggO2Rygd6P9DvxL3HNM6NfA27ubh7Jq', 'http://elastic-query-service-1:8183/elastic-query-service', false, '', false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', -1, true, false, '', false, 'client-secret', '', '', NULL, true, false, true, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', true, true, 'elastic-query-service-2', 0, false, 'lggO2Rygd6P9DvxL3HNM6NfA27ubh7Jq', 'http://elastic-query-service-2:8185/elastic-query-service', false, '', false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', -1, true, false, '', false, 'client-secret', '', '', NULL, true, false, true, false);
INSERT INTO keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', true, true, 'elastic-query-web-client-2', 0, false, 'j8mbzx15a4zJ78I498YnC5iJuHZWiTSx', 'http://elastic-query-web-client-2:8186/elastic-query-web-client', false, '', false, '245617d4-22a0-4661-9450-5c17c04f2d8c', 'openid-connect', -1, true, false, '', false, 'client-secret', '', '', NULL, true, false, true, false);


--
-- TOC entry 4119 (class 0 OID 16437)
-- Dependencies: 218
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', '+', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '+', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '+', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', '+', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '+', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '+', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', '1662989553', 'client.secret.creation.time');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'true', 'backchannel.logout.session.required');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'true', 'backchannel.logout.session.required');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'true', 'backchannel.logout.session.required');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', '1662997735', 'client.secret.creation.time');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', '1663315099', 'client.secret.creation.time');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'http://elastic-query-web-client-1:8184/elastic-query-web-client', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'http://elastic-query-service-1:8183/elastic-query-service', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', '1662997735', 'client.secret.creation.time');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'true', 'backchannel.logout.session.required');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'http://elastic-query-service-2:8185/elastic-query-service', 'post.logout.redirect.uris');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_attributes (client_id, value, name) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'http://elastic-query-web-client-2:8186/elastic-query-web-client', 'post.logout.redirect.uris');


--
-- TOC entry 4120 (class 0 OID 16442)
-- Dependencies: 219
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4121 (class 0 OID 16445)
-- Dependencies: 220
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4122 (class 0 OID 16448)
-- Dependencies: 221
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4123 (class 0 OID 16451)
-- Dependencies: 222
-- Data for Name: client_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('770af2ec-6531-4e95-a773-438a7f44eb33', 'offline_access', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('ef4c5a4a-3bb9-447b-a121-d9e4e0df61a2', 'role_list', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'SAML role list', 'saml');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('77e5519a-977c-49c7-a3d2-9b8751df489b', 'profile', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('64eac5f4-a886-4a0f-b73c-82bdee371ce1', 'email', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', 'address', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('3e83b076-747a-4944-b0b0-6ab91598c310', 'phone', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('a5eb6e68-546e-4c85-ae64-105c59f09e81', 'roles', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('e6a13fb5-7a68-438c-8dd9-b382541bb59b', 'web-origins', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('dc50d208-626d-445e-a180-9366eb813526', 'microprofile-jwt', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('7811627d-08bd-4639-a98a-4d1d7aa8e6d1', 'acr', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', 'offline_access', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('98154b18-1ae7-4c9b-914a-1df601b58711', 'role_list', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'SAML role list', 'saml');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('bb8484c0-6abb-4349-b46c-c76542fe4622', 'profile', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', 'email', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('30c23fd3-3cf7-426a-be44-5ed7aa749ad3', 'address', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', 'phone', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('47d79312-8b12-4772-9f20-ea1aa297b402', 'roles', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', 'web-origins', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('1b132754-ea05-4574-9742-511d178e37b3', 'microprofile-jwt', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('de1986bc-c2d2-4f6e-8186-5ae6307563d0', 'acr', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('7e22b14c-e3fd-40ae-8a33-851d76ff512a', 'app_user_role', '245617d4-22a0-4661-9450-5c17c04f2d8c', '', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('adcc6c78-e6a7-4097-b8fa-789fcb915bad', 'app_admin_role', '245617d4-22a0-4661-9450-5c17c04f2d8c', '', 'openid-connect');
INSERT INTO keycloak.client_scope (id, name, realm_id, description, protocol) VALUES ('b9e6df1b-a9e8-4844-8df0-509a774eedf7', 'app_super_user_role', '245617d4-22a0-4661-9450-5c17c04f2d8c', '', 'openid-connect');


--
-- TOC entry 4124 (class 0 OID 16456)
-- Dependencies: 223
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('770af2ec-6531-4e95-a773-438a7f44eb33', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('770af2ec-6531-4e95-a773-438a7f44eb33', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('ef4c5a4a-3bb9-447b-a121-d9e4e0df61a2', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('ef4c5a4a-3bb9-447b-a121-d9e4e0df61a2', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('77e5519a-977c-49c7-a3d2-9b8751df489b', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('77e5519a-977c-49c7-a3d2-9b8751df489b', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('77e5519a-977c-49c7-a3d2-9b8751df489b', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('64eac5f4-a886-4a0f-b73c-82bdee371ce1', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('64eac5f4-a886-4a0f-b73c-82bdee371ce1', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('64eac5f4-a886-4a0f-b73c-82bdee371ce1', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('3e83b076-747a-4944-b0b0-6ab91598c310', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('3e83b076-747a-4944-b0b0-6ab91598c310', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('3e83b076-747a-4944-b0b0-6ab91598c310', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('a5eb6e68-546e-4c85-ae64-105c59f09e81', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('a5eb6e68-546e-4c85-ae64-105c59f09e81', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('a5eb6e68-546e-4c85-ae64-105c59f09e81', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('e6a13fb5-7a68-438c-8dd9-b382541bb59b', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('e6a13fb5-7a68-438c-8dd9-b382541bb59b', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('e6a13fb5-7a68-438c-8dd9-b382541bb59b', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('dc50d208-626d-445e-a180-9366eb813526', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('dc50d208-626d-445e-a180-9366eb813526', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('7811627d-08bd-4639-a98a-4d1d7aa8e6d1', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('7811627d-08bd-4639-a98a-4d1d7aa8e6d1', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('98154b18-1ae7-4c9b-914a-1df601b58711', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('98154b18-1ae7-4c9b-914a-1df601b58711', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('bb8484c0-6abb-4349-b46c-c76542fe4622', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('bb8484c0-6abb-4349-b46c-c76542fe4622', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('bb8484c0-6abb-4349-b46c-c76542fe4622', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('30c23fd3-3cf7-426a-be44-5ed7aa749ad3', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('30c23fd3-3cf7-426a-be44-5ed7aa749ad3', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('30c23fd3-3cf7-426a-be44-5ed7aa749ad3', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('47d79312-8b12-4772-9f20-ea1aa297b402', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('47d79312-8b12-4772-9f20-ea1aa297b402', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('47d79312-8b12-4772-9f20-ea1aa297b402', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('1b132754-ea05-4574-9742-511d178e37b3', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('1b132754-ea05-4574-9742-511d178e37b3', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('de1986bc-c2d2-4f6e-8186-5ae6307563d0', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('de1986bc-c2d2-4f6e-8186-5ae6307563d0', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('7e22b14c-e3fd-40ae-8a33-851d76ff512a', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('7e22b14c-e3fd-40ae-8a33-851d76ff512a', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('7e22b14c-e3fd-40ae-8a33-851d76ff512a', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('7e22b14c-e3fd-40ae-8a33-851d76ff512a', '', 'gui.order');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('adcc6c78-e6a7-4097-b8fa-789fcb915bad', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('adcc6c78-e6a7-4097-b8fa-789fcb915bad', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('adcc6c78-e6a7-4097-b8fa-789fcb915bad', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('adcc6c78-e6a7-4097-b8fa-789fcb915bad', '', 'gui.order');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('b9e6df1b-a9e8-4844-8df0-509a774eedf7', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('b9e6df1b-a9e8-4844-8df0-509a774eedf7', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('b9e6df1b-a9e8-4844-8df0-509a774eedf7', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes (scope_id, value, name) VALUES ('b9e6df1b-a9e8-4844-8df0-509a774eedf7', '', 'gui.order');


--
-- TOC entry 4125 (class 0 OID 16461)
-- Dependencies: 224
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', '64eac5f4-a886-4a0f-b73c-82bdee371ce1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', '77e5519a-977c-49c7-a3d2-9b8751df489b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', 'a5eb6e68-546e-4c85-ae64-105c59f09e81', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', '7811627d-08bd-4639-a98a-4d1d7aa8e6d1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', 'e6a13fb5-7a68-438c-8dd9-b382541bb59b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', '3e83b076-747a-4944-b0b0-6ab91598c310', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', 'dc50d208-626d-445e-a180-9366eb813526', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', '770af2ec-6531-4e95-a773-438a7f44eb33', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '64eac5f4-a886-4a0f-b73c-82bdee371ce1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '77e5519a-977c-49c7-a3d2-9b8751df489b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', 'a5eb6e68-546e-4c85-ae64-105c59f09e81', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '7811627d-08bd-4639-a98a-4d1d7aa8e6d1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', 'e6a13fb5-7a68-438c-8dd9-b382541bb59b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '3e83b076-747a-4944-b0b0-6ab91598c310', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', 'dc50d208-626d-445e-a180-9366eb813526', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '770af2ec-6531-4e95-a773-438a7f44eb33', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', '64eac5f4-a886-4a0f-b73c-82bdee371ce1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', '77e5519a-977c-49c7-a3d2-9b8751df489b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', 'a5eb6e68-546e-4c85-ae64-105c59f09e81', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', '7811627d-08bd-4639-a98a-4d1d7aa8e6d1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', 'e6a13fb5-7a68-438c-8dd9-b382541bb59b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', '3e83b076-747a-4944-b0b0-6ab91598c310', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', 'dc50d208-626d-445e-a180-9366eb813526', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e9b254c1-e954-4ecb-92a3-564b4449dbf8', '770af2ec-6531-4e95-a773-438a7f44eb33', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', '64eac5f4-a886-4a0f-b73c-82bdee371ce1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', '77e5519a-977c-49c7-a3d2-9b8751df489b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', 'a5eb6e68-546e-4c85-ae64-105c59f09e81', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', '7811627d-08bd-4639-a98a-4d1d7aa8e6d1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', 'e6a13fb5-7a68-438c-8dd9-b382541bb59b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', '3e83b076-747a-4944-b0b0-6ab91598c310', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', 'dc50d208-626d-445e-a180-9366eb813526', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2326b487-7891-4716-9252-e03347239b67', '770af2ec-6531-4e95-a773-438a7f44eb33', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', '64eac5f4-a886-4a0f-b73c-82bdee371ce1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', '77e5519a-977c-49c7-a3d2-9b8751df489b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', 'a5eb6e68-546e-4c85-ae64-105c59f09e81', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', '7811627d-08bd-4639-a98a-4d1d7aa8e6d1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', 'e6a13fb5-7a68-438c-8dd9-b382541bb59b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', '3e83b076-747a-4944-b0b0-6ab91598c310', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', 'dc50d208-626d-445e-a180-9366eb813526', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('e1c32b88-cebc-4a96-af10-9967ef085c8f', '770af2ec-6531-4e95-a773-438a7f44eb33', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '64eac5f4-a886-4a0f-b73c-82bdee371ce1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '77e5519a-977c-49c7-a3d2-9b8751df489b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', 'a5eb6e68-546e-4c85-ae64-105c59f09e81', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '7811627d-08bd-4639-a98a-4d1d7aa8e6d1', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', 'e6a13fb5-7a68-438c-8dd9-b382541bb59b', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '3e83b076-747a-4944-b0b0-6ab91598c310', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', 'dc50d208-626d-445e-a180-9366eb813526', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '770af2ec-6531-4e95-a773-438a7f44eb33', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('4b5c82f0-883a-49c6-806e-a785d83eef14', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('2cf6cede-1b54-493c-afac-0b4582bbb9a2', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('61d68154-ab52-4440-94fe-7b1b07b85c8e', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'adcc6c78-e6a7-4097-b8fa-789fcb915bad', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'b9e6df1b-a9e8-4844-8df0-509a774eedf7', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', '7e22b14c-e3fd-40ae-8a33-851d76ff512a', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', '7e22b14c-e3fd-40ae-8a33-851d76ff512a', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'adcc6c78-e6a7-4097-b8fa-789fcb915bad', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'b9e6df1b-a9e8-4844-8df0-509a774eedf7', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'b9e6df1b-a9e8-4844-8df0-509a774eedf7', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'adcc6c78-e6a7-4097-b8fa-789fcb915bad', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', '7e22b14c-e3fd-40ae-8a33-851d76ff512a', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'adcc6c78-e6a7-4097-b8fa-789fcb915bad', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', '7e22b14c-e3fd-40ae-8a33-851d76ff512a', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'b9e6df1b-a9e8-4844-8df0-509a774eedf7', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.client_scope_client (client_id, scope_id, default_scope) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', '1b132754-ea05-4574-9742-511d178e37b3', false);


--
-- TOC entry 4126 (class 0 OID 16467)
-- Dependencies: 225
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.client_scope_role_mapping (scope_id, role_id) VALUES ('770af2ec-6531-4e95-a773-438a7f44eb33', '202e7881-fbb2-4e5e-875f-f860befa00dc');
INSERT INTO keycloak.client_scope_role_mapping (scope_id, role_id) VALUES ('ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', '17363bd8-ae6f-40df-ae97-b0d9b1e3bcac');
INSERT INTO keycloak.client_scope_role_mapping (scope_id, role_id) VALUES ('7e22b14c-e3fd-40ae-8a33-851d76ff512a', 'edb6d233-6c36-4ef7-bc16-c21cb6445bd3');
INSERT INTO keycloak.client_scope_role_mapping (scope_id, role_id) VALUES ('adcc6c78-e6a7-4097-b8fa-789fcb915bad', '84400dcb-7e86-4666-b93e-9da8c442105b');
INSERT INTO keycloak.client_scope_role_mapping (scope_id, role_id) VALUES ('b9e6df1b-a9e8-4844-8df0-509a774eedf7', 'b45d29fa-f5a9-460e-ac74-815a9aa4642c');


--
-- TOC entry 4127 (class 0 OID 16470)
-- Dependencies: 226
-- Data for Name: client_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4128 (class 0 OID 16475)
-- Dependencies: 227
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4129 (class 0 OID 16478)
-- Dependencies: 228
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4130 (class 0 OID 16483)
-- Dependencies: 229
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4131 (class 0 OID 16486)
-- Dependencies: 230
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4132 (class 0 OID 16489)
-- Dependencies: 231
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4133 (class 0 OID 16494)
-- Dependencies: 232
-- Data for Name: component; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('10518619-2a55-4395-ac67-540b6e35c788', 'Trusted Hosts', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('87218f83-7812-4a3b-ad1b-36a8acaca4b5', 'Consent Required', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('ecffb2aa-3cc2-4fa4-9118-4a4a90e4154b', 'Full Scope Disabled', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e928f537-a7c4-4b79-96c5-d3b722ea71f1', 'Max Clients Limit', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('d3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'Allowed Protocol Mapper Types', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('dfc20c1e-c61e-43d3-9bd4-bd8da79e5af8', 'Allowed Client Scopes', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'Allowed Protocol Mapper Types', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'authenticated');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('80955295-eb27-40ad-8909-a16e4e220bd4', 'Allowed Client Scopes', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'authenticated');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2c373fc7-c316-4db6-8961-6118e167e1a0', 'rsa-generated', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('a7dc3f94-39ea-4ce1-b50c-0f4f3f8d38d5', 'rsa-enc-generated', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('ca1369e8-766f-4ebf-a1ba-b1f35a7a342a', 'hmac-generated', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('ffd96d00-dd9b-4207-8601-400db2614d10', 'aes-generated', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('6079602b-de92-4660-99aa-25908b060484', 'rsa-generated', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'rsa-generated', 'org.keycloak.keys.KeyProvider', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('bef82d36-202c-4086-896c-e16ce87d4a74', 'rsa-enc-generated', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('a7c663f5-267e-47d6-81e7-01a1f7171166', 'hmac-generated', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'hmac-generated', 'org.keycloak.keys.KeyProvider', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('3fb1753a-7c1d-4c34-afdb-a431869f18fd', 'aes-generated', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'aes-generated', 'org.keycloak.keys.KeyProvider', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL);
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('0f6ed621-bc81-4772-a12a-58c13b7228ef', 'Trusted Hosts', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('440f5fac-8344-4123-b9ff-6529a86103f0', 'Consent Required', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('0a79f660-832b-469a-a117-748d8d38f66e', 'Full Scope Disabled', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('ff715b52-02a2-42a7-90ff-5c60fe4714cd', 'Max Clients Limit', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'Allowed Protocol Mapper Types', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('f8411a9b-1ef9-493d-9da3-8705b5ca7433', 'Allowed Client Scopes', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'anonymous');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('c72613e6-f457-4927-b7d9-29d916188866', 'Allowed Protocol Mapper Types', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'authenticated');
INSERT INTO keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('1ff11401-2283-4f8f-b5ba-e3850f015d4d', 'Allowed Client Scopes', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'authenticated');


--
-- TOC entry 4134 (class 0 OID 16499)
-- Dependencies: 233
-- Data for Name: component_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('43ed2322-dfbc-44c7-bcfb-27895f980e41', 'e928f537-a7c4-4b79-96c5-d3b722ea71f1', 'max-clients', '200');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('7c819022-6517-42a7-a6f8-7bd2efb330db', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('b9c22011-c280-4444-b08f-1eb09758ff7a', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('285740ea-11a8-49d0-8ca7-a6a521bc657d', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('5cf7208b-7b2f-44e9-819d-04464c2f09c5', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('af6f54df-468d-4b91-8496-59042d9a7656', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('576a6ce8-8064-4009-809f-6fb4c00366d2', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('568b776f-39e5-4783-94b9-d3c9def7bf45', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('49c2445d-800b-437b-9f5a-0567fe9f88ad', 'd3fe8fbd-94a1-45f7-a3f3-e015a1d499f3', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('9fe22e54-dd8d-44fd-b8d8-597121ad8516', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('a2db26b9-6183-4b97-8e1e-fdee4b9290e4', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('b4c3688c-fb2d-4387-be07-ec0cbeea0331', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('f943cb91-415c-40a0-b7e4-0193f6815367', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('2b31560e-0611-4e78-934a-325fdd5c8959', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('055528f8-6843-4345-b58c-d6dc772a11e4', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('4f55a86f-526b-4a1d-9aa9-7f022b6daa0f', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('78ea5c8b-100f-4b40-b377-525c0c6237f2', '2f62c1c9-08b6-4f74-a085-32ee33ed0f33', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('91b6e7c6-c2c4-4295-9d4d-d8ae6b459588', 'dfc20c1e-c61e-43d3-9bd4-bd8da79e5af8', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('3599997f-0b16-4cf3-ab41-5e129b71259d', '10518619-2a55-4395-ac67-540b6e35c788', 'client-uris-must-match', 'true');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('af5a42bf-7201-4f53-9c72-6b5c39335ac8', '10518619-2a55-4395-ac67-540b6e35c788', 'host-sending-registration-request-must-match', 'true');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('d5298002-09e4-4506-8640-61d010eb8f88', '80955295-eb27-40ad-8909-a16e4e220bd4', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('3f4a1428-1583-42ec-87c2-ad608972ca3c', 'ca1369e8-766f-4ebf-a1ba-b1f35a7a342a', 'secret', '0SipKbFeWnkpvV77yFQ-Nn_IPjkoE_QFql2ymbDms-oghhUQ7PulPRUHWBUN7HlOPe5do7_8wg1LG6tSC3Szsg');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('2ac66268-5fbb-44e6-895d-ebfb49430111', 'ca1369e8-766f-4ebf-a1ba-b1f35a7a342a', 'algorithm', 'HS256');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('639e4dfc-d5f3-4040-9106-af18899a4e2e', 'ca1369e8-766f-4ebf-a1ba-b1f35a7a342a', 'kid', '530bbbe3-bec7-40f7-a340-d0692b13c4c9');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('e3530b5e-479b-4247-836a-92ac7ed2829e', 'ca1369e8-766f-4ebf-a1ba-b1f35a7a342a', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('7bc66167-aaab-470e-a2b4-85a354465598', 'a7dc3f94-39ea-4ce1-b50c-0f4f3f8d38d5', 'privateKey', 'MIIEowIBAAKCAQEAlYQsMv7LIbecwrhddI5GqUuoVDlpyVXSm/SeIm8q8ma3C6wo9VVaBHTBCVghNVBhr54N0BS+dinxQyEdO02VtixT0IFAmGndkzbmBrm0aXruVlWWy5WmiUd4OLi+n06J/sjPdFyzwykBhj1ydleDatDSvQ1W+tgI6eghm+HlqcdsGCKAtpirchdQ1NMyAmuFJVUDcdTPEfckai+X6to8AdF64bLjlBIYA+bT3xjinxwq1Ur9fXPHq7QHhOh0fEH222DKOL5N1nItJA81nkQDKTcU9pOtbFzpY+zpKggCfbRvy9yHHvsLDZV95Ta/aPlhH14ipjhFWJV+4r35v4jDRwIDAQABAoIBADEZZfBbJrbMVrDFHX+Ep2S6AS2jav9gbRik1HdHXWmb3Hl7UDn8jOKQusGITON2oZWryCpwXXltXZqnWbObT1IzLVT31RAYF9jbut8zhbDr2y/DzJDPdJB5RVwPIx4qivt9006JkMjCgwsjy55cL75YlBPcOReH8Slq/vpzTNmbMCtMsNhqlpaYLiFKkFhW4PJmq/EDSw8xHERYx6caIc+TU33qeiOUUAO+kZyuh2OiMDvgJf8I47WYd07yUz7+jjGiFoQkrKNJgyKE4OPYII0K7PaZ8kdquyCV5HQ5+ykE8QShTyQczotZ6v5yTaF3NW771mgHrLXLW4VVsIrnXV0CgYEA0i6xjyOuNqtGrC5XrnRmNdXlr1gtJPtDDVItCTCtM4yn6rtGzOyXBs11jTPqLPCu0IynrEZ3ego6ms+vhq3V81azXfWtVpouCjUpdoyKfihuxYEiCnazEQvOfjk87ntlWruREJFQGuvoDxmtD9hosLamOJoJOTtY+ZrUTIbhXsUCgYEAthv8LIG9eY/ti6i6dICwjEl/cTke3r+We90NLIRUVd5Oq0MVczQHE8Ht3eli2FFiBjDRx+zvIGTZVHLsbesjlprLARKY9Xmz1Qs4L7H2j3Z3e7VJLszBk0QFl5x1OgyrFx1dE5TPtC81ZToigEE4kMol1oeC0k938dhUF2zo+psCgYBkJB0zPuPNZlOYy8e49fqQ4eW6Yn+35AMxgJq2izuqmPSUUUBNeNgIRLIiYb7MRKx17t4gpb5dJiyAAD34JDEQ7JkvRlOdNH6FHIkx04pUy3zjm0AVzjJJB+ANocXXNnG3BjD6vNF20jlRoIElUI2ozI1r4HBOlWkyG8PU5lrQpQKBgDxUMwtPg8SUwL4mjHZx94rSAm0w3iAu2hx4k5eu0v2LYwZrd9ytXLbX5QRB/+PnuhCQ9b5EqMdTgYfvdpHHdwe6igv17EROKBwo1lk+nI7UUSrjWLYvUOWHgE7EnzU24ysKKD6HavOnPAon4ywX7zRQM47JX7ZqazLsVpdYFiqHAoGBAJsK16u4ekV6ujUvcdmjdAvRb/9nsSBnsDAblV/dIW8sJHlhw2m53kPUW+io+CyUa8QpEsvP7eunXlKy+EY0qRPk64xNao06HyxyL2UIJUwanMd19jDUnxmtWLUdnvkRFMhNyh3UOdtmmvz8x5A6a9hOpYT/QUobp4DF+/oV+PWr');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('13be4df9-b89c-4d1c-8e98-15cddc1a4b2b', 'a7dc3f94-39ea-4ce1-b50c-0f4f3f8d38d5', 'keyUse', 'ENC');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('773f1735-ca93-408e-a864-ead6e1de5288', 'a7dc3f94-39ea-4ce1-b50c-0f4f3f8d38d5', 'certificate', 'MIICmzCCAYMCBgGDMcmxfjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwOTEyMTI1OTA1WhcNMzIwOTEyMTMwMDQ1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCVhCwy/ssht5zCuF10jkapS6hUOWnJVdKb9J4ibyryZrcLrCj1VVoEdMEJWCE1UGGvng3QFL52KfFDIR07TZW2LFPQgUCYad2TNuYGubRpeu5WVZbLlaaJR3g4uL6fTon+yM90XLPDKQGGPXJ2V4Nq0NK9DVb62Ajp6CGb4eWpx2wYIoC2mKtyF1DU0zICa4UlVQNx1M8R9yRqL5fq2jwB0XrhsuOUEhgD5tPfGOKfHCrVSv19c8ertAeE6HR8QfbbYMo4vk3Wci0kDzWeRAMpNxT2k61sXOlj7OkqCAJ9tG/L3Ice+wsNlX3lNr9o+WEfXiKmOEVYlX7ivfm/iMNHAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACPG88LBvRLIRuuL/swGzas2uNPzWq1t5ztn+SRvEYKTojZ2c9ELpszhkL1QyqjFAbrpBntqdtnpxZkVD6bbZptaEyjGyJkNM46jnykK7LgF4PUPwwfm5dT3n5JKZfwui0GH1Cc8OGpIrnp2IA4vYEH6Gu+R/B1cCeMg1SxGfL2iJI8IUrib+Qf5kdkbaV/MykpqTcWmwKQLjW7k27Dh/BrMT0zLAmyZPDelJgOgdyJZVUwc9QsMmIHKZ9jxIJ4JtHbmBWcOVX88uUBIE6nTBYmGkBwwPtkJ8JfLI4j6gMiO/vIdxpbsMBv7CvwLBKcKisqVBLcVAsp7/7Qa8bPb324=');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('7ebf4dbf-6c0c-4b5b-b7f1-a5d246ff77e6', 'a7dc3f94-39ea-4ce1-b50c-0f4f3f8d38d5', 'algorithm', 'RSA-OAEP');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('fbf45f4a-fa7c-46f8-b37c-f0e86eaabf57', 'a7dc3f94-39ea-4ce1-b50c-0f4f3f8d38d5', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('d75f7329-6da0-495b-876c-fbfc77876953', 'ffd96d00-dd9b-4207-8601-400db2614d10', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('2506fbf5-8c8f-45f8-8d28-354b9b599a5e', 'ffd96d00-dd9b-4207-8601-400db2614d10', 'secret', 'Y8ETYQ0V1rlZu1hq3THSlQ');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('2f0f2014-7a14-4dad-985e-533f10c91d19', 'ffd96d00-dd9b-4207-8601-400db2614d10', 'kid', '13967585-8f3b-46c5-9178-04b9d6cf4c40');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('6b734d7f-69b7-4c50-86fc-ec803907d984', '2c373fc7-c316-4db6-8961-6118e167e1a0', 'keyUse', 'SIG');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('214ce280-5291-40c2-8968-23404a666669', '2c373fc7-c316-4db6-8961-6118e167e1a0', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('a818b154-6a35-499a-be0d-e51b36f3b39b', '2c373fc7-c316-4db6-8961-6118e167e1a0', 'privateKey', 'MIIEowIBAAKCAQEAuH2J3RZuh8YThBvdX7/1GX7fMwV1Bq6lnm8MYycIOxUgrJIKJBn47y/Sl4RBgkGItP1RtahfFGsG15CLS68ji/+MAh1qmcMvJIKc3sj17RngP8w9ctf/rHr6gLfIcE+m9r+Y7iWyKmNTqly3YWIaJHOdEnsdw9g0M/pd13wMdsyZrBsac/NzhtS/i4cHmlO87LHu9tTwmsGajozofOW2deWlCXc8omdXCYWZF9eP41sDikWJ8qAoWCSSzUZQ3IhuyVrBg17SUe5XaWEJkDVCrVRahCBZmEmIJ9eaHKCjje/D/vA9u9z5+RmAroVcg4VG1UOccqeFCq+85WDyRDhdIQIDAQABAoIBAFPR2aKkr+gpArHpdQ0tKf8A6QiFyLMWAzI10uNzluY9BaDSIyBe2n5VdHEZiifTfXh5hTeq/TPKIowq5FapBlXzb1mAou+kQdVtMDd6B13HfV6O/TYh08w5/XkgxsTcM4f06db9MnLWuOr0f+6TQzxfeLQuUoopvyIEdMFT31fTett50iXgVE1z3yHU+DdYN3DqaIgaa9UJW1tGZYSQD5xBoZnJktyVfewQGsg50c7zHLDWICcrwZlnlJ59VGJPEz8D4yA2rS/HWfGNnyvkVcKuDLTVGZrjsY8g5TQtL6cFiD/L26FwAX5C4AZuG+cJWBd0nPFmTZoVjC012wgQObcCgYEA+qBitSzC1+X/ow9YY5rF6m64P8peUsNew9pwGFl9W1xHjSd//Ha7Ow2ZhZxeZtVga+YdZZkPUJMMGEU8wP1iwRiZpua5Tr4HOXPBWHZwKuG7LuHEl0bs6vzviyH7delTr1/Pn4RouBb/IqZ3Nk3amFnpL9orqP3J9gDX/7sB1qMCgYEAvHImxGWQzkU6IP9C7SlodWZPwHEnpKjgFyrzouKDALtDvdgg6wJhAjL9cvPL/XQYGBP4mwVftYlxhBQZIishJIojAAke6xOwjv+JTkqy/liX2yGD7799uD9cWQe8cwmOw8VC76+E+v0inUPE7bnZekP+zusjxaihVlNR6nnzLWsCgYEA76arnEi365B/eKF0yJG3zKqgvka5GPS+ShM2+uGfj9vWg3AQ3w19jUM82NkkH7rLX4GD/KF2Vnq1pwOVy4i/hJsMWd7ntRbae6JncDqYmTiOL48s1+a3JyBDwkv1UtOQ9PJt6z/GjrlWsABzn9akPuhCpUI+W3KKSxSVdnCQmncCgYBOEUQ6LJFWwpsYPGdvdK4PpLj5UmdH8aYUMvkHy6rVzL59kWHhufSSQql4y8MAVu38W5msLwe9XxklzGW1IAT07D0fsKecX2XPd9FcG9oXQIB4iWPtGHlusOEDCQ9q4NTCCaB3R1Fh4ShL2l1k1o9f9XdEJWmGYxujdZUD/E1fzQKBgDZCc5DV8QCGlZLIFvQia7MPIb0UWtz2R0hZcpEz53Dtbe575Zo4mLukueniGfZf6HOTUbBSZPtxZG+ydxxrHsMnY/dCvPOJmtqbim6SWBffhqdr4e1Whxaf3jhhF+i2IbNZNep24saHm4FN+Rcmj33P4hjumkajTJezBU+Jw/cR');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('f8c8a79e-d116-46f3-9819-e5e1f1f9b117', '2c373fc7-c316-4db6-8961-6118e167e1a0', 'certificate', 'MIICmzCCAYMCBgGDMcmwsDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwOTEyMTI1OTA1WhcNMzIwOTEyMTMwMDQ1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4fYndFm6HxhOEG91fv/UZft8zBXUGrqWebwxjJwg7FSCskgokGfjvL9KXhEGCQYi0/VG1qF8UawbXkItLryOL/4wCHWqZwy8kgpzeyPXtGeA/zD1y1/+sevqAt8hwT6b2v5juJbIqY1OqXLdhYhokc50Sex3D2DQz+l3XfAx2zJmsGxpz83OG1L+LhweaU7zsse721PCawZqOjOh85bZ15aUJdzyiZ1cJhZkX14/jWwOKRYnyoChYJJLNRlDciG7JWsGDXtJR7ldpYQmQNUKtVFqEIFmYSYgn15ocoKON78P+8D273Pn5GYCuhVyDhUbVQ5xyp4UKr7zlYPJEOF0hAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAAKT714GjRBUc07+eKzwYtOnxzYbiuh0nykQYAVm+lPYmQI+JYf+pzDtr126Bk5jR6OHLfc6HDH65AfVYIkpiiior1hOStyi16AxkM0m9D6ZPB+PjlEcxbDIY/WWBGXBiQWxvO8hgHSBOBg5mcvZ7w9/RUI9xnUIgA55DSLnQukCf17D2ffiMjt5g86sajq7GiEOjkaB5qrDQ/SyMm0D/wpQnFDWi4rIDPQG2nPOo3vSM0wo0kBqIhwPFPy8ITN0jzS0hBQ/KFLRdDIOnL7p35t93KvvItWhTFZFIA2md1sMwhv3MEipF/ht6pEfOwdsnyROBWa2PcQRI0enhhPBHo=');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('01d37376-bb39-4eec-8791-378acf352680', '6079602b-de92-4660-99aa-25908b060484', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('0c0c3fa0-dd37-4bc2-a9ea-154ca90493cf', '6079602b-de92-4660-99aa-25908b060484', 'privateKey', 'MIIEpQIBAAKCAQEAqJrKPYdONJin4Skliyy3I4HPea3kxyi44BCKhUUctLRr5Cpc3fVMTRCBvJ2cawuVuMLauRLyeygmpuDdYHoAPGZw023Xk3vrCDleGWFpEOO2lxhwcHdU+YD357grr9+C8MWN8+f6iU58PS8ERMlshAF2sG6ZxlfCRBcRtPNqQ/4t+3m+gCvZ7/8XrWJ1u72KH83FQVQtbPrRtK62I+C5u/bNDC040IXh5jvp86RjwGXF3CKlTc459jWdZIYctXU8UEmyPqxKE68xz51JrSGkWCyT9cwpPxdlLdHiHf8c2kUkK6K/Bk+lBKLqMyImhyhAsk5dHucaHmVELisR6k754QIDAQABAoIBAE5uy3v58IiJJzeYI43tvDg5T+Hj4hQ/vlkFeNrsPqFVeQdIKbFbRiZncmLi0vv9BKZRhtwnk0N1dx2UZ4dU2b0/TmccpvdF4x0NStf1t6GSvMLnLI81BAOZWjmiNDh5enk0/YckOCkdqK/xqkOxi9iQsbz7hm99LbLtJGCQB7QezVg6dZKHLonoaykiCTtFEeiPW7UIytrl/8EPZWwJiZSFgoRI73K3WQWLk7lV6QlRuDXOMdXwoxgo42OB8L/HnuOfy6wdy4K9UGlWfXIXHdcSY/EO98eNc/8+Rr2EOLLmAQURRLLHwsZDnu/xvaELmZjfxHy7iFrCgXHfG9Zs780CgYEA3nOTcE59soCVbeLeYqwIfEur1Jio3bVizHzxOAMcLRTuyVZeoevgkWypjvKv65PQCC0CgGiNSPsAdB3QPgCCBGLWfqoJJt/XpIbi7i1KWsJdwEp8rJ9vlynqeToVxHMsaT1UqDubTYSUCdB4o8ZulaNA5eQKfliW+Mvk7oBQt1sCgYEAwghKr2PDHu/JafXvbWTZuw/zYn52KL/KYVdJW5qtExaaDh/Mfg7EVcysCARGXMofnZg7XKRobIDQFOj9Dsg5/cjVT07t/d+N3ePY0tmKqCR4rFvkaMs+Er9XCA68lDjbUKhWsIYqA1QJoG3OxZyZb15o6AGRlrk+vL2R9R3klHMCgYEAgSVYU7s9/oPoPQOZWG/H/WFxQNvgLddApLdk07/6e7HLb9hU2Gy407TiO7tpprsJ67U13pbUb6pJeSBV5akl0qYPITpWVdtetoYY+W4R3N86zohwGUf24SvUlMzEFmlHP1H79C+m2jo+N/RwFaT+TqGY696YuQF1pLu7DTwxoEECgYEAgi1P9iXnZd0Yc4e1z94GmhMUhjM0ERjDrdUC+XtnvNPAHdPFvZkoriu4C1Ta5CwTVAcrZHdFO+6cLDs4dG9vQM46FpBs6ZPPuVvBP40GEtMNRw4Lyyb4iVloCZbhfEw9D/sw1hPdIgiCwOiK/leXNXnQxj8vL0EvTy+cOiiJD/MCgYEAslhGFwkOLhloal7/e2oFz82P4CDjUqLAAzSoc0CCjLh7weNkO14Q+Mzm/YT4md9NYTPE6PYnX8QBjqxgceuXahtZ+vdxVuVLLAQ5A3nheMcDVhlMlJXIVEYpzRQIDDVcLYkohGhGZLF6FJB9CgUttbRcnRYC+nDvd5FioviofOs=');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('710d22fb-c4c4-488a-a659-e2735e700834', '6079602b-de92-4660-99aa-25908b060484', 'keyUse', 'SIG');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('ed1ac69e-a45d-4d7d-8bba-2a391b324495', '6079602b-de92-4660-99aa-25908b060484', 'certificate', 'MIICtTCCAZ0CBgGDMczIyDANBgkqhkiG9w0BAQsFADAeMRwwGgYDVQQDDBNtaWNyb3NlcnZpY2VzX3JlYWxtMB4XDTIyMDkxMjEzMDIyN1oXDTMyMDkxMjEzMDQwN1owHjEcMBoGA1UEAwwTbWljcm9zZXJ2aWNlc19yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKiayj2HTjSYp+EpJYsstyOBz3mt5McouOAQioVFHLS0a+QqXN31TE0QgbydnGsLlbjC2rkS8nsoJqbg3WB6ADxmcNNt15N76wg5XhlhaRDjtpcYcHB3VPmA9+e4K6/fgvDFjfPn+olOfD0vBETJbIQBdrBumcZXwkQXEbTzakP+Lft5voAr2e//F61idbu9ih/NxUFULWz60bSutiPgubv2zQwtONCF4eY76fOkY8BlxdwipU3OOfY1nWSGHLV1PFBJsj6sShOvMc+dSa0hpFgsk/XMKT8XZS3R4h3/HNpFJCuivwZPpQSi6jMiJocoQLJOXR7nGh5lRC4rEepO+eECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAAO9+LY/JyS2yNVZbirUczX5ULDwlzzUqd//JNgFmqJoA9ffl1peZ293MG5lrpCBcRKdVjxo+1k0oscHxv7gVPmVm3nov5jNzZWqjdedfeKLfQmv6QXAhnUeVspBztxQXJtqvDlNY5YZnSv/LIg8hXPTzN/QEm/fpjbfiwyQHkAEjDQLAoSOSsx0Pl+cIKIpuNJqKa6dHRtnBSS30L0mrKGDeWblb81c5qVY8zhnWImecBHPkw8RTrOUSREjazKFLh9OWHsn6UWjRB7b1T3GlqpNQUu7/8tEBII1KWSrsZL0hBrUM1niAjeS43jHgwKZHXbt2fEVmOsR0x31kbD9xXw==');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('41b49c72-6431-4a75-8486-643283dad3bf', 'bef82d36-202c-4086-896c-e16ce87d4a74', 'keyUse', 'ENC');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('b71218d0-d8bc-4868-a459-3238a7906276', 'bef82d36-202c-4086-896c-e16ce87d4a74', 'certificate', 'MIICtTCCAZ0CBgGDMczKdjANBgkqhkiG9w0BAQsFADAeMRwwGgYDVQQDDBNtaWNyb3NlcnZpY2VzX3JlYWxtMB4XDTIyMDkxMjEzMDIyOFoXDTMyMDkxMjEzMDQwOFowHjEcMBoGA1UEAwwTbWljcm9zZXJ2aWNlc19yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMa/MilU7sjniWuy2LLnP8aOvlbdAqfrHXi4WbOXzLDJLTmOUyVMcsnmGKVY4SmmtXTgTzy/45SSmQE3K9A47deF8tjQrx7oLMtqhYcQR82pBaVET8BOt1k7lQR6tXKFUYVobCOp+w6W9c+QMT6zbqRzncUNK3+PBanKr8q3xFlS3aXLsOgt4HadVN/eATOETdCz/oWEooQcTGaVF0YpwYmQmQViGSoij6pPLxCHRKMRMteDa/W20FYUJ//9a7WjNS4bnn7vTpD0Pbvl5MKDjHBG8YeC/YTTKr6tQiY1ZxjzhqEAaGmbcQyFT6cdMfkE+nDaZh8yBSbuF9cfdHhCc7cCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAPgc9EhLnjLAIG9PsKgxshZYdBK8+XkLjWRxoHdpzOOszGQ3BymWJ0UdgEC5seeb9oReQjzH/JVhv1phMPE11L4Hf/1/lBfaBvQl9v6EYGG+foUTEZik+NXFDqJ1buVAoImIk0tuu+DwcVpHtBD2bqRLqwrYf5LkCmZiILVVIPYSDDXOrKIBkTvp72UdPUiP6O/rFNk17pJBdjbKf5YOtIP+Y+QQMq2ALkcST07XIRbP8Wg3XxvbEEZjK+uagE+Yo0a/devlt8P9iGUu9Xgoj2DSL5i4eQ/80gvVFYsN63kyTa/YHIESguMIqts8CYpSzYhNyXhar2ngOcpUB0bhM2g==');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('d2f3fc53-8749-47ca-8dfa-65c8e6aa22fe', 'bef82d36-202c-4086-896c-e16ce87d4a74', 'privateKey', 'MIIEowIBAAKCAQEAxr8yKVTuyOeJa7LYsuc/xo6+Vt0Cp+sdeLhZs5fMsMktOY5TJUxyyeYYpVjhKaa1dOBPPL/jlJKZATcr0Djt14Xy2NCvHugsy2qFhxBHzakFpURPwE63WTuVBHq1coVRhWhsI6n7Dpb1z5AxPrNupHOdxQ0rf48FqcqvyrfEWVLdpcuw6C3gdp1U394BM4RN0LP+hYSihBxMZpUXRinBiZCZBWIZKiKPqk8vEIdEoxEy14Nr9bbQVhQn//1rtaM1Lhuefu9OkPQ9u+XkwoOMcEbxh4L9hNMqvq1CJjVnGPOGoQBoaZtxDIVPpx0x+QT6cNpmHzIFJu4X1x90eEJztwIDAQABAoIBACkkQh+BN+750x4qxyX9rduOCAPWO2sERjULwHHnbhV4h7ae6kJR2X9G9PohdHbZTj3UA0MZm+RRFoBEafrwFfgj/9n3FRFKUZ+IPPzxF1QQ9Zy5D+NIyDaeGWJ0fmQnCfGaZKxbTx+9i0P83tzSawh68IFukP8WXb9AuHQ351rv6WFLpCP7h3kazZeLc/teeS1IO5mMQ4DJ6zfjhxKvAnu3zhYZwl07qzdcBL7Nvjif0M8xMDcdRZjRRs2kyv96R6n/ZKcAgX3TPdQk7DQj8cQIr4jIXUndODSZzJo1f8YYQXvK0ZEtSBHNUh6zxB7APbjOJnPnZ3FwslmlZGo7ZhkCgYEA8Lv4SutMy9Etvo6f2yVRdbOOUkOeyzawI+S11z+UP5Px3R0CaBOnVwW9A8TroOvmBoJ7iXcTCfJcIkGJKI1Gg5Gr/IQjB2FUb39Z7ogWi/GiIf9rEXHJOS6bKu7+sUHFJaA/jzx858ecufykGcOJ1/1jeo1jWocW+3puXb8LXQkCgYEA01mcf08cjOInhNZQMBkApitnuFtzTJGyFyG0su4/5CoEQiQs/4Vq4XtTfYsr/DV72mhpDFVOI4yQu5iDoRjO1ffl3pBW/dxAjAFDCDg3F5K47yrz9snJCfSl0fZr7von+wJ2+/3TD5priNfix4ekxZJsVrP5YbRDsVpsOx8UOr8CgYB/0X4i4U50RYuBSx8Lb4QR95VQjoDIqy/Yzv3R3PssyrO30EhP1GecZ/qU/sCRP89xk2Red6/PLzTGJ3/Y3TIcd4MW313t9DqtvLOWWAGIqnKIlKJXr8/Eob9Xi3AF08MGmFBHEDnNownPIppK56zP1sUz89BV57ZHLhldgytYaQKBgHIrx3Gyf97PUL/esiS5bPNXIUmjBU8Iqab7S00ZjSQpWnGMb059eTZjU7/PDazKC6T5oD3MW1Cy34Cnq/u7lghaSTAI0yWB9NBs4hQvofs3BHYWwwG/Eb4yDd21e6r2MeDT/Qi1nm2gYpTi4pwc93LPXX0c7gvMwICvMyZg7KGrAoGBALuIq+Kp7Gl82eGRyqVM9JkE9RW3ivHFruK3GWP4or9mzjYPqUzywZScr89Xw3TGwSGoBQjqHeoTezivWh/E0Z3Zed0QBNsGF19co0HPGujljyaLnGsYCUOYwf2o0ZEooZFwCbe2MFgnb4Ya1645VzumkdbXQj9SfhiYIt2t1sbU');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('5d9430a3-7261-4777-83ee-cd1445e3b173', 'bef82d36-202c-4086-896c-e16ce87d4a74', 'algorithm', 'RSA-OAEP');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('59058e4d-3515-4753-832c-06d6ae133d59', 'bef82d36-202c-4086-896c-e16ce87d4a74', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('70256996-2f5e-4b0f-a531-eab27ee8c8cf', 'a7c663f5-267e-47d6-81e7-01a1f7171166', 'secret', 'WfVbRI7rmtm3utlvz_yd9cclYtzRz3seo0MWlYVO-aYp-dQcq1jEY0bc28Y6DbvICv92IfiJvz9VFqh0Jo9BFQ');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('5c3ffa64-1da2-4f9e-b1b4-20a086d36c5a', 'a7c663f5-267e-47d6-81e7-01a1f7171166', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('12464c99-4b2d-4ecf-b52a-cec0eae82c31', 'a7c663f5-267e-47d6-81e7-01a1f7171166', 'kid', '5938ead7-5af2-40e0-8286-b42a66c94238');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('87ce8902-f7a3-477a-b01f-839de7376914', 'a7c663f5-267e-47d6-81e7-01a1f7171166', 'algorithm', 'HS256');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('d87a0b7e-2322-4227-8b2f-c7d8addc10cc', '3fb1753a-7c1d-4c34-afdb-a431869f18fd', 'kid', '1e89f4e2-8573-4d4f-b8b3-2cfe4f199c1c');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('e85fc1d7-3049-43ab-957c-51cae0b0bbc6', '3fb1753a-7c1d-4c34-afdb-a431869f18fd', 'priority', '100');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('4d6c8b95-0962-4cce-8ef4-7627e7408157', '3fb1753a-7c1d-4c34-afdb-a431869f18fd', 'secret', '_geqljuPHyS5E-AiUuDMxA');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('67a6ce7f-6ff9-41d1-9dd1-96c3a8e9cbe2', 'f8411a9b-1ef9-493d-9da3-8705b5ca7433', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('43435e53-66d1-4589-aa64-2dfa48535684', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('4cdad613-811e-4730-8fb5-c53c06ffc2c8', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('6ef776b8-bd92-42cc-8a62-6990248a6482', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('a9559f05-6bd0-4d93-961d-c181be845ace', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('49870447-74a3-47e5-a7d7-6143c600fd9f', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('7a7d2921-a770-410d-80f2-ab3f38d870a8', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('247895fa-eae9-4490-bfb9-51eccefc144a', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('b61805bc-e5cb-4a3f-82f1-22a49c93ee10', 'c72613e6-f457-4927-b7d9-29d916188866', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('44595d84-6a87-425e-ad7f-6b70e45cb712', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('7d13e81e-be5e-4639-ad10-4a581daf05a1', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('35f49d3b-47d2-41e2-835a-f80b40b24418', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('ac02c086-f036-40e5-bf7b-0fefc1f41177', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('5a81366c-5926-4aa2-817c-ba78d073170a', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('678cf818-7308-444d-b558-d460c2b2c684', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('2152f785-b8fd-47f9-95fa-ef2fd7f91c20', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('aba8a345-f963-4337-ad3a-6660e8423488', '371cfae7-53a4-48ec-a641-ec5d6dffa2a6', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('5af90b57-2084-41ec-8ba8-af9b9330b28a', '1ff11401-2283-4f8f-b5ba-e3850f015d4d', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('09fd1732-1179-4369-a853-0b4acdd6897f', 'ff715b52-02a2-42a7-90ff-5c60fe4714cd', 'max-clients', '200');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('264bf22f-79a5-4bd3-b0d4-477405eea160', '0f6ed621-bc81-4772-a12a-58c13b7228ef', 'host-sending-registration-request-must-match', 'true');
INSERT INTO keycloak.component_config (id, component_id, name, value) VALUES ('abf67c1e-815d-4480-ab30-1187deeb9426', '0f6ed621-bc81-4772-a12a-58c13b7228ef', 'client-uris-must-match', 'true');


--
-- TOC entry 4135 (class 0 OID 16504)
-- Dependencies: 234
-- Data for Name: composite_role; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'b61bff72-d4f4-46ec-bb4c-431a7bc6e64c');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'de5fe800-a9f5-4ef4-a683-e740e15819e3');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '95cdf65a-d723-4107-81a4-5a9942eaecc5');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '354f5c22-edb9-4291-9b07-ff88ec637d5f');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '80d875a9-b74e-4e29-8209-2a2299e6a7c7');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'c303d722-ae2b-4e1d-8fb3-51482b4ddeb0');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'ab110e96-24f0-4add-85b5-ba4430829504');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'ffdff5a3-e0fd-4501-9222-8e2b27ceffc7');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'c51b1725-3d44-4229-90ab-f056ec4865c8');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'c0ba2e22-ecb4-4485-af6d-bb189d94c3db');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'f47049d5-3ae6-4475-8656-27318f5eeb14');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'a9e0dfb8-9b22-475a-8067-5f551f9a11f9');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '6cbf85b4-76ef-4abd-b0ab-3ba6852ccc32');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '12d8b8d8-53db-45a7-ae29-1191bcdca9ae');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'b5481338-7c3e-4dba-96b4-578e0bb66365');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '6ae7f34b-a2ef-46d6-86b5-f933afb057c6');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '48601e1e-59ed-471a-8ad8-5a9bdfcd66c3');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '8ba7d54d-1440-41ec-b091-e92fee3b0c87');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('354f5c22-edb9-4291-9b07-ff88ec637d5f', '8ba7d54d-1440-41ec-b091-e92fee3b0c87');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('354f5c22-edb9-4291-9b07-ff88ec637d5f', 'b5481338-7c3e-4dba-96b4-578e0bb66365');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('68f4138d-de4f-4c52-9bf7-b26f5ddd5ddd', 'fbfc3e6e-2b4b-450d-8794-0f7e0d303f29');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('80d875a9-b74e-4e29-8209-2a2299e6a7c7', '6ae7f34b-a2ef-46d6-86b5-f933afb057c6');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('68f4138d-de4f-4c52-9bf7-b26f5ddd5ddd', '28922b05-6c68-4ac9-a432-7e2d767b64d9');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('28922b05-6c68-4ac9-a432-7e2d767b64d9', '815fc9e3-3933-4895-a154-783b6c0ba57a');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ee2faa7e-abd3-4b41-9965-27426900a1f9', 'b46225e3-2168-486d-9af4-7ec5416a397b');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'b28dfe88-7acb-4dd2-a6f7-49e223b96f62');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('68f4138d-de4f-4c52-9bf7-b26f5ddd5ddd', '202e7881-fbb2-4e5e-875f-f860befa00dc');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('68f4138d-de4f-4c52-9bf7-b26f5ddd5ddd', '0cab6891-6523-490a-a643-37364b8f94c3');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '65ffbfcf-575a-42d1-af1c-7142a5ba3810');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'f61efb0c-413a-47c8-afa5-f591c754deb2');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '77edf79e-7dff-48eb-8d8f-c67d90f0d321');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '91cf5faa-a136-49af-b9dc-a9a41bb5466c');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '310a62db-2127-4ef9-b315-a86acae15f0a');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'f16c357d-1d7e-43e1-bac0-dbe614401413');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'e18e3f51-1384-4039-9fc4-eb9eb740cc07');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'e55b6e4d-8e48-4aa5-8c52-10c2dfd25ad4');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'd70290c8-2efa-46e2-9f1c-38dcbd7e6201');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '60be72e7-f2c9-4bff-adce-8c9b915fe322');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'a2c76fc0-fd2a-4f6d-a799-c52669143d6b');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '9e2d8497-31ed-4f4c-967c-906e7ecf87ee');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '93b47597-f906-436e-bca1-629a91e50cc7');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '781b73e3-ce84-4a39-8757-03a243f52f78');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'd30db0d6-f325-4811-964b-97b488841441');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'c29418a9-95a4-4289-8093-2c5cfaedba3f');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'b53bc85c-21ab-4f6b-b515-9cb28a315770');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('77edf79e-7dff-48eb-8d8f-c67d90f0d321', 'b53bc85c-21ab-4f6b-b515-9cb28a315770');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('77edf79e-7dff-48eb-8d8f-c67d90f0d321', '781b73e3-ce84-4a39-8757-03a243f52f78');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('91cf5faa-a136-49af-b9dc-a9a41bb5466c', 'd30db0d6-f325-4811-964b-97b488841441');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '7e90aa8d-dd1c-4257-9e2d-baa12c014f81');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '0eeba848-441b-4fab-86ad-1e9b4c0d4319');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '66cd4399-da1c-46ba-9d6a-51e07f867274');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '3d22e640-0db0-43fb-8cce-6e3e755fc18e');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', 'e554e966-8919-433f-89d7-e001206a3ec6');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '4188ebdd-2d82-47d5-82f8-81447bb8e250');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '25b5f143-5acf-4ef5-8a7a-2edd9aaa3bd5');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', 'c2ba6c7b-d453-4294-aca5-69d0b9012230');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '79bbf929-e915-4926-995f-4b771c2f1327');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '60d500d9-7ccf-446f-a853-1e8452525308');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '8e760c3f-68f5-4f62-801d-9943952ab53a');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '39611bf8-d6ae-4ce4-ad88-e66d3521b2e6');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', 'caf39c65-4549-4201-b8c6-3e3570a745f8');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '18fad6ee-c5a4-49ad-8dd1-20c0d21a7774');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '86ca70c2-a981-4531-bf95-6acdda3204e1');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', 'f7245b6b-2c66-41a6-993e-2e60eac16257');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '6a42a00b-bdd2-411c-bdf6-ee21312e05d3');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('3d22e640-0db0-43fb-8cce-6e3e755fc18e', '86ca70c2-a981-4531-bf95-6acdda3204e1');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('66cd4399-da1c-46ba-9d6a-51e07f867274', '6a42a00b-bdd2-411c-bdf6-ee21312e05d3');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('66cd4399-da1c-46ba-9d6a-51e07f867274', '18fad6ee-c5a4-49ad-8dd1-20c0d21a7774');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', '780ea1c7-da6f-4afa-b8d0-ac5ef928df0e');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', '4f225590-1032-4e44-bdb1-b92d1172b9d3');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('4f225590-1032-4e44-bdb1-b92d1172b9d3', '5c6dead6-8a1f-449e-9bda-8997157995cd');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('f6ef98b9-4f3b-4c36-b636-172d4944b67a', '19219a55-d1f9-4fb7-a77e-51306b4cb6a7');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', '93dea3a9-130f-4df9-a088-5296b0c35200');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', 'd386399f-b2db-450a-9e93-8b232152f9f0');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', '17363bd8-ae6f-40df-ae97-b0d9b1e3bcac');
INSERT INTO keycloak.composite_role (composite, child_role) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', '9b9b2f45-7c7e-4e0d-b06d-8d0f18fd9e14');


--
-- TOC entry 4136 (class 0 OID 16507)
-- Dependencies: 235
-- Data for Name: credential; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('a2afef81-86fa-4633-bc5e-3d88b367e8fe', NULL, 'password', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b', 1662987645900, NULL, '{"value":"6fawDl/Vzq/wj7dtSALr1OeLolGewEz87meFyeYKyCVJS0J92TUv83/rIR9aNaT9+VKQq4t760hURsHTXVLl2Q==","salt":"BmyjHqcdMQP6U42LkgNJVA==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('9b6e74a2-3f66-4452-81ec-0ea2d84a9ce3', NULL, 'password', 'e41bd033-77df-4e07-8d38-eb5498998873', 1662989233510, 'My password', '{"value":"7sK5/4dy6Kd4W78Y5u+CpJukboPMT5j4qTycGXMCclvwbCPKK3CrjNmI04dfVM6GmiFhrRG3PGgUWB0QqWsang==","salt":"mAS52FAiLz0eZBCAkFetUw==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('f12798f4-4c91-4967-b5da-2bb09817fbdd', NULL, 'password', '388258cb-1542-4104-920d-87e04a0381d5', 1662989252262, 'My password', '{"value":"gTIRdvS5CbqzaIB99YQn/XoVPPHDy5esEoAUxNNVpSSGRJsAjyP+cEyTta4kftOV13L5bnMHRsjiqK2sXSOsEg==","salt":"9Icrja/Hl1lJdl122/kz/w==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('6a112a74-6fac-4cb2-929d-b4d6b3c1c111', NULL, 'password', 'edd8fe96-cf80-4bcf-b39e-7428d83ca4c8', 1663320519149, 'My password', '{"value":"NQdq+BanQ64jbj6K6r8M1HtbApQZIkvJXYcsndj9IsCmrKkVayV5kUNZ9NdXAZnW3vqldpQZhQz1hxEA/1M+Yw==","salt":"msrOnEQQNQtRTevYOOlBMw==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);


--
-- TOC entry 4137 (class 0 OID 16512)
-- Dependencies: 236
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-09-12 13:00:42.454978', 1, 'EXECUTED', '8:bda77d94bf90182a1e30c24f1c155ec7', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-09-12 13:00:42.462464', 2, 'MARK_RAN', '8:1ecb330f30986693d1cba9ab579fa219', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-09-12 13:00:42.494776', 3, 'EXECUTED', '8:cb7ace19bc6d959f305605d255d4c843', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-09-12 13:00:42.498083', 4, 'EXECUTED', '8:80230013e961310e6872e871be424a63', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-09-12 13:00:42.59279', 5, 'EXECUTED', '8:67f4c20929126adc0c8e9bf48279d244', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-09-12 13:00:42.594643', 6, 'MARK_RAN', '8:7311018b0b8179ce14628ab412bb6783', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-09-12 13:00:42.659505', 7, 'EXECUTED', '8:037ba1216c3640f8785ee6b8e7c8e3c1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-09-12 13:00:42.661921', 8, 'MARK_RAN', '8:7fe6ffe4af4df289b3157de32c624263', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-09-12 13:00:42.666008', 9, 'EXECUTED', '8:9c136bc3187083a98745c7d03bc8a303', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-09-12 13:00:42.735745', 10, 'EXECUTED', '8:b5f09474dca81fb56a97cf5b6553d331', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-09-12 13:00:42.773979', 11, 'EXECUTED', '8:ca924f31bd2a3b219fdcfe78c82dacf4', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-09-12 13:00:42.776002', 12, 'MARK_RAN', '8:8acad7483e106416bcfa6f3b824a16cd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-09-12 13:00:42.7907', 13, 'EXECUTED', '8:9b1266d17f4f87c78226f5055408fd5e', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-09-12 13:00:42.803495', 14, 'EXECUTED', '8:d80ec4ab6dbfe573550ff72396c7e910', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-09-12 13:00:42.804982', 15, 'MARK_RAN', '8:d86eb172171e7c20b9c849b584d147b2', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-09-12 13:00:42.806379', 16, 'MARK_RAN', '8:5735f46f0fa60689deb0ecdc2a0dea22', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-09-12 13:00:42.807725', 17, 'EXECUTED', '8:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-09-12 13:00:42.845737', 18, 'EXECUTED', '8:5c1a8fd2014ac7fc43b90a700f117b23', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-09-12 13:00:42.893829', 19, 'EXECUTED', '8:1f6c2c2dfc362aff4ed75b3f0ef6b331', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-09-12 13:00:42.90227', 20, 'EXECUTED', '8:dee9246280915712591f83a127665107', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-09-12 13:00:43.273745', 45, 'EXECUTED', '8:a164ae073c56ffdbc98a615493609a52', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-09-12 13:00:42.906459', 21, 'MARK_RAN', '8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-09-12 13:00:42.909605', 22, 'MARK_RAN', '8:dee9246280915712591f83a127665107', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-09-12 13:00:42.943545', 23, 'EXECUTED', '8:d9fa18ffa355320395b86270680dd4fe', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-09-12 13:00:42.951617', 24, 'EXECUTED', '8:90cff506fedb06141ffc1c71c4a1214c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-09-12 13:00:42.95429', 25, 'MARK_RAN', '8:11a788aed4961d6d29c427c063af828c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-09-12 13:00:42.983984', 26, 'EXECUTED', '8:a4218e51e1faf380518cce2af5d39b43', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-09-12 13:00:43.041016', 27, 'EXECUTED', '8:d9e9a1bfaa644da9952456050f07bbdc', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-09-12 13:00:43.043966', 28, 'EXECUTED', '8:d1bf991a6163c0acbfe664b615314505', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-09-12 13:00:43.088616', 29, 'EXECUTED', '8:88a743a1e87ec5e30bf603da68058a8c', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-09-12 13:00:43.099642', 30, 'EXECUTED', '8:c5517863c875d325dea463d00ec26d7a', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-09-12 13:00:43.115233', 31, 'EXECUTED', '8:ada8b4833b74a498f376d7136bc7d327', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-09-12 13:00:43.119363', 32, 'EXECUTED', '8:b9b73c8ea7299457f99fcbb825c263ba', 'customChange', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-09-12 13:00:43.124076', 33, 'EXECUTED', '8:07724333e625ccfcfc5adc63d57314f3', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-09-12 13:00:43.125805', 34, 'MARK_RAN', '8:8b6fd445958882efe55deb26fc541a7b', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-09-12 13:00:43.147908', 35, 'EXECUTED', '8:29b29cfebfd12600897680147277a9d7', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-09-12 13:00:43.151929', 36, 'EXECUTED', '8:73ad77ca8fd0410c7f9f15a471fa52bc', 'addColumn tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-09-12 13:00:43.15605', 37, 'EXECUTED', '8:64f27a6fdcad57f6f9153210f2ec1bdb', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-09-12 13:00:43.159849', 38, 'EXECUTED', '8:27180251182e6c31846c2ddab4bc5781', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-09-12 13:00:43.16294', 39, 'EXECUTED', '8:d56f201bfcfa7a1413eb3e9bc02978f9', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-09-12 13:00:43.164509', 40, 'MARK_RAN', '8:91f5522bf6afdc2077dfab57fbd3455c', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-09-12 13:00:43.165986', 41, 'MARK_RAN', '8:0f01b554f256c22caeb7d8aee3a1cdc8', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-09-12 13:00:43.170243', 42, 'EXECUTED', '8:ab91cf9cee415867ade0e2df9651a947', 'customChange', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-09-12 13:00:43.26645', 43, 'EXECUTED', '8:ceac9b1889e97d602caf373eadb0d4b7', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-09-12 13:00:43.269799', 44, 'EXECUTED', '8:84b986e628fe8f7fd8fd3c275c5259f2', 'addColumn tableName=USER_ENTITY', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-09-12 13:00:43.277807', 46, 'EXECUTED', '8:70a2b4f1f4bd4dbf487114bdb1810e64', 'customChange', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-09-12 13:00:43.279445', 47, 'MARK_RAN', '8:7be68b71d2f5b94b8df2e824f2860fa2', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-09-12 13:00:43.30662', 48, 'EXECUTED', '8:bab7c631093c3861d6cf6144cd944982', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-09-12 13:00:43.309223', 49, 'EXECUTED', '8:fa809ac11877d74d76fe40869916daad', 'addColumn tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-09-12 13:00:43.335954', 50, 'EXECUTED', '8:fac23540a40208f5f5e326f6ceb4d291', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-09-12 13:00:43.353802', 51, 'EXECUTED', '8:2612d1b8a97e2b5588c346e817307593', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-09-12 13:00:43.356052', 52, 'EXECUTED', '8:9842f155c5db2206c88bcb5d1046e941', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-09-12 13:00:43.357896', 53, 'EXECUTED', '8:2e12e06e45498406db72d5b3da5bbc76', 'update tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-09-12 13:00:43.359773', 54, 'EXECUTED', '8:33560e7c7989250c40da3abdabdc75a4', 'update tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-09-12 13:00:43.363962', 55, 'EXECUTED', '8:87a8d8542046817a9107c7eb9cbad1cd', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-09-12 13:00:43.366947', 56, 'EXECUTED', '8:3ea08490a70215ed0088c273d776311e', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-09-12 13:00:43.380796', 57, 'EXECUTED', '8:2d56697c8723d4592ab608ce14b6ed68', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-09-12 13:00:43.447719', 58, 'EXECUTED', '8:3e423e249f6068ea2bbe48bf907f9d86', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-09-12 13:00:43.463323', 59, 'EXECUTED', '8:15cabee5e5df0ff099510a0fc03e4103', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-09-12 13:00:43.467168', 60, 'EXECUTED', '8:4b80200af916ac54d2ffbfc47918ab0e', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-09-12 13:00:43.472922', 61, 'EXECUTED', '8:66564cd5e168045d52252c5027485bbb', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-09-12 13:00:43.476258', 62, 'EXECUTED', '8:1c7064fafb030222be2bd16ccf690f6f', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-09-12 13:00:43.478814', 63, 'EXECUTED', '8:2de18a0dce10cdda5c7e65c9b719b6e5', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-09-12 13:00:43.480703', 64, 'EXECUTED', '8:03e413dd182dcbd5c57e41c34d0ef682', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-09-12 13:00:43.482596', 65, 'EXECUTED', '8:d27b42bb2571c18fbe3fe4e4fb7582a7', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-09-12 13:00:43.490421', 66, 'EXECUTED', '8:698baf84d9fd0027e9192717c2154fb8', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-09-12 13:00:43.493622', 67, 'EXECUTED', '8:ced8822edf0f75ef26eb51582f9a821a', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-09-12 13:00:43.496985', 68, 'EXECUTED', '8:f0abba004cf429e8afc43056df06487d', 'addColumn tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-09-12 13:00:43.504523', 69, 'EXECUTED', '8:6662f8b0b611caa359fcf13bf63b4e24', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-09-12 13:00:43.50798', 70, 'EXECUTED', '8:9e6b8009560f684250bdbdf97670d39e', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-09-12 13:00:43.510521', 71, 'EXECUTED', '8:4223f561f3b8dc655846562b57bb502e', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-09-12 13:00:43.515507', 72, 'EXECUTED', '8:215a31c398b363ce383a2b301202f29e', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-09-12 13:00:43.520397', 73, 'EXECUTED', '8:83f7a671792ca98b3cbd3a1a34862d3d', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-09-12 13:00:43.521786', 74, 'MARK_RAN', '8:f58ad148698cf30707a6efbdf8061aa7', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-09-12 13:00:43.534905', 75, 'EXECUTED', '8:79e4fd6c6442980e58d52ffc3ee7b19c', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-09-12 13:00:43.539146', 76, 'EXECUTED', '8:87af6a1e6d241ca4b15801d1f86a297d', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-09-12 13:00:43.541393', 77, 'EXECUTED', '8:b44f8d9b7b6ea455305a6d72a200ed15', 'addColumn tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-09-12 13:00:43.542707', 78, 'MARK_RAN', '8:2d8ed5aaaeffd0cb004c046b4a903ac5', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-09-12 13:00:43.554487', 79, 'EXECUTED', '8:e290c01fcbc275326c511633f6e2acde', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-09-12 13:00:43.555931', 80, 'MARK_RAN', '8:c9db8784c33cea210872ac2d805439f8', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-09-12 13:00:43.559479', 81, 'EXECUTED', '8:95b676ce8fc546a1fcfb4c92fae4add5', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-09-12 13:00:43.560996', 82, 'MARK_RAN', '8:38a6b2a41f5651018b1aca93a41401e5', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-09-12 13:00:43.563783', 83, 'EXECUTED', '8:3fb99bcad86a0229783123ac52f7609c', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-09-12 13:00:43.56499', 84, 'MARK_RAN', '8:64f27a6fdcad57f6f9153210f2ec1bdb', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-09-12 13:00:43.568347', 85, 'EXECUTED', '8:ab4f863f39adafd4c862f7ec01890abc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-09-12 13:00:43.571833', 86, 'EXECUTED', '8:13c419a0eb336e91ee3a3bf8fda6e2a7', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-09-12 13:00:43.576973', 87, 'EXECUTED', '8:e3fb1e698e0471487f51af1ed80fe3ac', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-09-12 13:00:43.582034', 88, 'EXECUTED', '8:babadb686aab7b56562817e60bf0abd0', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.585944', 89, 'EXECUTED', '8:72d03345fda8e2f17093d08801947773', 'addColumn tableName=REALM; customChange', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.589724', 90, 'EXECUTED', '8:61c9233951bd96ffecd9ba75f7d978a4', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.592945', 91, 'EXECUTED', '8:ea82e6ad945cec250af6372767b25525', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.598166', 92, 'EXECUTED', '8:d3f4a33f41d960ddacd7e2ef30d126b3', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.599368', 93, 'MARK_RAN', '8:1284a27fbd049d65831cb6fc07c8a783', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.604187', 94, 'EXECUTED', '8:9d11b619db2ae27c25853b8a37cd0dea', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.605422', 95, 'MARK_RAN', '8:3002bb3997451bb9e8bac5c5cd8d6327', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-09-12 13:00:43.609801', 96, 'EXECUTED', '8:dfbee0d6237a23ef4ccbb7a4e063c163', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-09-12 13:00:43.617931', 97, 'EXECUTED', '8:75f3e372df18d38c62734eebb986b960', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-09-12 13:00:43.619385', 98, 'MARK_RAN', '8:7fee73eddf84a6035691512c85637eef', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-09-12 13:00:43.6269', 99, 'MARK_RAN', '8:7a11134ab12820f999fbf3bb13c3adc8', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-09-12 13:00:43.630693', 100, 'EXECUTED', '8:c0f6eaac1f3be773ffe54cb5b8482b70', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-09-12 13:00:43.632029', 101, 'MARK_RAN', '8:18186f0008b86e0f0f49b0c4d0e842ac', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-09-12 13:00:43.635082', 102, 'EXECUTED', '8:09c2780bcb23b310a7019d217dc7b433', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-09-12 13:00:43.638374', 103, 'EXECUTED', '8:276a44955eab693c970a42880197fff2', 'customChange', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-09-12 13:00:43.642467', 104, 'EXECUTED', '8:ba8ee3b694d043f2bfc1a1079d0760d7', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2022-09-12 13:00:43.645601', 105, 'EXECUTED', '8:5e06b1d75f5d17685485e610c2851b17', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2022-09-12 13:00:43.649071', 106, 'EXECUTED', '8:4b80546c1dc550ac552ee7b24a4ab7c0', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '2987642144');
INSERT INTO keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2022-09-12 13:00:43.65349', 107, 'EXECUTED', '8:af510cd1bb2ab6339c45372f3e491696', 'customChange', '', NULL, '4.8.0', NULL, NULL, '2987642144');


--
-- TOC entry 4138 (class 0 OID 16517)
-- Dependencies: 237
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);
INSERT INTO keycloak.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1000, false, NULL, NULL);
INSERT INTO keycloak.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1001, false, NULL, NULL);


--
-- TOC entry 4139 (class 0 OID 16520)
-- Dependencies: 238
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '770af2ec-6531-4e95-a773-438a7f44eb33', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'ef4c5a4a-3bb9-447b-a121-d9e4e0df61a2', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '77e5519a-977c-49c7-a3d2-9b8751df489b', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '64eac5f4-a886-4a0f-b73c-82bdee371ce1', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '3e83b076-747a-4944-b0b0-6ab91598c310', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'a5eb6e68-546e-4c85-ae64-105c59f09e81', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e6a13fb5-7a68-438c-8dd9-b382541bb59b', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dc50d208-626d-445e-a180-9366eb813526', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '7811627d-08bd-4639-a98a-4d1d7aa8e6d1', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', 'ebc7d485-5c73-4ca5-a17c-9d8b56b3ae0e', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', '98154b18-1ae7-4c9b-914a-1df601b58711', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', 'bb8484c0-6abb-4349-b46c-c76542fe4622', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', '30c23fd3-3cf7-426a-be44-5ed7aa749ad3', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', '47d79312-8b12-4772-9f20-ea1aa297b402', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589', true);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', '1b132754-ea05-4574-9742-511d178e37b3', false);
INSERT INTO keycloak.default_client_scope (realm_id, scope_id, default_scope) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', 'de1986bc-c2d2-4f6e-8186-5ae6307563d0', true);


--
-- TOC entry 4140 (class 0 OID 16524)
-- Dependencies: 239
-- Data for Name: event_entity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4141 (class 0 OID 16529)
-- Dependencies: 240
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4142 (class 0 OID 16534)
-- Dependencies: 241
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4143 (class 0 OID 16539)
-- Dependencies: 242
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4144 (class 0 OID 16542)
-- Dependencies: 243
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4145 (class 0 OID 16547)
-- Dependencies: 244
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4146 (class 0 OID 16550)
-- Dependencies: 245
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4147 (class 0 OID 16556)
-- Dependencies: 246
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4148 (class 0 OID 16559)
-- Dependencies: 247
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4149 (class 0 OID 16564)
-- Dependencies: 248
-- Data for Name: federated_user; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4150 (class 0 OID 16569)
-- Dependencies: 249
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4151 (class 0 OID 16575)
-- Dependencies: 250
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.group_role_mapping (role_id, group_id) VALUES ('84400dcb-7e86-4666-b93e-9da8c442105b', '394ab059-5b9f-4fc5-b4b6-55a164722994');
INSERT INTO keycloak.group_role_mapping (role_id, group_id) VALUES ('b45d29fa-f5a9-460e-ac74-815a9aa4642c', '651125c8-1f91-418a-aeb6-d88a1aa8452e');
INSERT INTO keycloak.group_role_mapping (role_id, group_id) VALUES ('edb6d233-6c36-4ef7-bc16-c21cb6445bd3', 'b464da35-f538-4413-ab9f-e2428d28b6b0');


--
-- TOC entry 4152 (class 0 OID 16578)
-- Dependencies: 251
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4153 (class 0 OID 16589)
-- Dependencies: 252
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4154 (class 0 OID 16594)
-- Dependencies: 253
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4155 (class 0 OID 16599)
-- Dependencies: 254
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4156 (class 0 OID 16604)
-- Dependencies: 255
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.keycloak_group (id, name, parent_group, realm_id) VALUES ('b464da35-f538-4413-ab9f-e2428d28b6b0', 'app_user_group', ' ', '245617d4-22a0-4661-9450-5c17c04f2d8c');
INSERT INTO keycloak.keycloak_group (id, name, parent_group, realm_id) VALUES ('394ab059-5b9f-4fc5-b4b6-55a164722994', 'app_admin_group', ' ', '245617d4-22a0-4661-9450-5c17c04f2d8c');
INSERT INTO keycloak.keycloak_group (id, name, parent_group, realm_id) VALUES ('651125c8-1f91-418a-aeb6-d88a1aa8452e', 'app_super_user_group', ' ', '245617d4-22a0-4661-9450-5c17c04f2d8c');


--
-- TOC entry 4157 (class 0 OID 16607)
-- Dependencies: 256
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('68f4138d-de4f-4c52-9bf7-b26f5ddd5ddd', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', false, '${role_default-roles}', 'default-roles-master', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b61bff72-d4f4-46ec-bb4c-431a7bc6e64c', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', false, '${role_create-realm}', 'create-realm', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', false, '${role_admin}', 'admin', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('de5fe800-a9f5-4ef4-a683-e740e15819e3', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_create-client}', 'create-client', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('95cdf65a-d723-4107-81a4-5a9942eaecc5', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_view-realm}', 'view-realm', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('354f5c22-edb9-4291-9b07-ff88ec637d5f', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_view-users}', 'view-users', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('80d875a9-b74e-4e29-8209-2a2299e6a7c7', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_view-clients}', 'view-clients', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c303d722-ae2b-4e1d-8fb3-51482b4ddeb0', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_view-events}', 'view-events', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ab110e96-24f0-4add-85b5-ba4430829504', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_view-identity-providers}', 'view-identity-providers', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ffdff5a3-e0fd-4501-9222-8e2b27ceffc7', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_view-authorization}', 'view-authorization', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c51b1725-3d44-4229-90ab-f056ec4865c8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_manage-realm}', 'manage-realm', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c0ba2e22-ecb4-4485-af6d-bb189d94c3db', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_manage-users}', 'manage-users', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f47049d5-3ae6-4475-8656-27318f5eeb14', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_manage-clients}', 'manage-clients', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a9e0dfb8-9b22-475a-8067-5f551f9a11f9', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_manage-events}', 'manage-events', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6cbf85b4-76ef-4abd-b0ab-3ba6852ccc32', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('12d8b8d8-53db-45a7-ae29-1191bcdca9ae', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_manage-authorization}', 'manage-authorization', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b5481338-7c3e-4dba-96b4-578e0bb66365', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_query-users}', 'query-users', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6ae7f34b-a2ef-46d6-86b5-f933afb057c6', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_query-clients}', 'query-clients', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('48601e1e-59ed-471a-8ad8-5a9bdfcd66c3', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_query-realms}', 'query-realms', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8ba7d54d-1440-41ec-b091-e92fee3b0c87', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_query-groups}', 'query-groups', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fbfc3e6e-2b4b-450d-8794-0f7e0d303f29', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, '${role_view-profile}', 'view-profile', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('28922b05-6c68-4ac9-a432-7e2d767b64d9', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, '${role_manage-account}', 'manage-account', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('815fc9e3-3933-4895-a154-783b6c0ba57a', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, '${role_manage-account-links}', 'manage-account-links', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('48366878-1243-4f5e-b8a5-8975aa2a44cb', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, '${role_view-applications}', 'view-applications', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b46225e3-2168-486d-9af4-7ec5416a397b', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, '${role_view-consent}', 'view-consent', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ee2faa7e-abd3-4b41-9965-27426900a1f9', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, '${role_manage-consent}', 'manage-consent', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('94c6e769-03fc-47f1-9783-53cdae1bbc1e', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', true, '${role_delete-account}', 'delete-account', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '9dd782c9-5f36-43a9-89a6-45af1332b5f6', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9e181448-3b96-4acc-adec-b4cd9f0d20c0', '2326b487-7891-4716-9252-e03347239b67', true, '${role_read-token}', 'read-token', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '2326b487-7891-4716-9252-e03347239b67', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b28dfe88-7acb-4dd2-a6f7-49e223b96f62', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', true, '${role_impersonation}', 'impersonation', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'e1c32b88-cebc-4a96-af10-9967ef085c8f', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('202e7881-fbb2-4e5e-875f-f860befa00dc', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', false, '${role_offline-access}', 'offline_access', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0cab6891-6523-490a-a643-37364b8f94c3', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', false, '${role_uma_authorization}', 'uma_authorization', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, '${role_default-roles}', 'default-roles-microservices_realm', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('65ffbfcf-575a-42d1-af1c-7142a5ba3810', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_create-client}', 'create-client', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f61efb0c-413a-47c8-afa5-f591c754deb2', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_view-realm}', 'view-realm', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('77edf79e-7dff-48eb-8d8f-c67d90f0d321', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_view-users}', 'view-users', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('91cf5faa-a136-49af-b9dc-a9a41bb5466c', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_view-clients}', 'view-clients', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('310a62db-2127-4ef9-b315-a86acae15f0a', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_view-events}', 'view-events', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f16c357d-1d7e-43e1-bac0-dbe614401413', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_view-identity-providers}', 'view-identity-providers', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e18e3f51-1384-4039-9fc4-eb9eb740cc07', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_view-authorization}', 'view-authorization', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e55b6e4d-8e48-4aa5-8c52-10c2dfd25ad4', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_manage-realm}', 'manage-realm', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d70290c8-2efa-46e2-9f1c-38dcbd7e6201', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_manage-users}', 'manage-users', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('60be72e7-f2c9-4bff-adce-8c9b915fe322', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_manage-clients}', 'manage-clients', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a2c76fc0-fd2a-4f6d-a799-c52669143d6b', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_manage-events}', 'manage-events', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9e2d8497-31ed-4f4c-967c-906e7ecf87ee', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('93b47597-f906-436e-bca1-629a91e50cc7', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_manage-authorization}', 'manage-authorization', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('781b73e3-ce84-4a39-8757-03a243f52f78', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_query-users}', 'query-users', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d30db0d6-f325-4811-964b-97b488841441', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_query-clients}', 'query-clients', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c29418a9-95a4-4289-8093-2c5cfaedba3f', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_query-realms}', 'query-realms', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b53bc85c-21ab-4f6b-b515-9cb28a315770', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_query-groups}', 'query-groups', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('175a1555-b55d-40e2-8525-bfa087cc745f', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_realm-admin}', 'realm-admin', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7e90aa8d-dd1c-4257-9e2d-baa12c014f81', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_create-client}', 'create-client', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0eeba848-441b-4fab-86ad-1e9b4c0d4319', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_view-realm}', 'view-realm', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('66cd4399-da1c-46ba-9d6a-51e07f867274', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_view-users}', 'view-users', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3d22e640-0db0-43fb-8cce-6e3e755fc18e', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_view-clients}', 'view-clients', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e554e966-8919-433f-89d7-e001206a3ec6', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_view-events}', 'view-events', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4188ebdd-2d82-47d5-82f8-81447bb8e250', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_view-identity-providers}', 'view-identity-providers', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('25b5f143-5acf-4ef5-8a7a-2edd9aaa3bd5', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_view-authorization}', 'view-authorization', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c2ba6c7b-d453-4294-aca5-69d0b9012230', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_manage-realm}', 'manage-realm', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('79bbf929-e915-4926-995f-4b771c2f1327', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_manage-users}', 'manage-users', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('60d500d9-7ccf-446f-a853-1e8452525308', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_manage-clients}', 'manage-clients', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8e760c3f-68f5-4f62-801d-9943952ab53a', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_manage-events}', 'manage-events', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('39611bf8-d6ae-4ce4-ad88-e66d3521b2e6', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_manage-identity-providers}', 'manage-identity-providers', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('caf39c65-4549-4201-b8c6-3e3570a745f8', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_manage-authorization}', 'manage-authorization', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('18fad6ee-c5a4-49ad-8dd1-20c0d21a7774', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_query-users}', 'query-users', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('86ca70c2-a981-4531-bf95-6acdda3204e1', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_query-clients}', 'query-clients', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f7245b6b-2c66-41a6-993e-2e60eac16257', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_query-realms}', 'query-realms', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6a42a00b-bdd2-411c-bdf6-ee21312e05d3', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_query-groups}', 'query-groups', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('780ea1c7-da6f-4afa-b8d0-ac5ef928df0e', '2652cd8c-5772-4dd4-85ec-efc910ac815e', true, '${role_view-profile}', 'view-profile', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2652cd8c-5772-4dd4-85ec-efc910ac815e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4f225590-1032-4e44-bdb1-b92d1172b9d3', '2652cd8c-5772-4dd4-85ec-efc910ac815e', true, '${role_manage-account}', 'manage-account', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2652cd8c-5772-4dd4-85ec-efc910ac815e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('5c6dead6-8a1f-449e-9bda-8997157995cd', '2652cd8c-5772-4dd4-85ec-efc910ac815e', true, '${role_manage-account-links}', 'manage-account-links', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2652cd8c-5772-4dd4-85ec-efc910ac815e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('01929510-7b1c-4e5c-b060-a8478d73da68', '2652cd8c-5772-4dd4-85ec-efc910ac815e', true, '${role_view-applications}', 'view-applications', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2652cd8c-5772-4dd4-85ec-efc910ac815e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('19219a55-d1f9-4fb7-a77e-51306b4cb6a7', '2652cd8c-5772-4dd4-85ec-efc910ac815e', true, '${role_view-consent}', 'view-consent', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2652cd8c-5772-4dd4-85ec-efc910ac815e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f6ef98b9-4f3b-4c36-b636-172d4944b67a', '2652cd8c-5772-4dd4-85ec-efc910ac815e', true, '${role_manage-consent}', 'manage-consent', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2652cd8c-5772-4dd4-85ec-efc910ac815e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8ce8fc45-6433-4d7e-9eb5-4811308ca4c0', '2652cd8c-5772-4dd4-85ec-efc910ac815e', true, '${role_delete-account}', 'delete-account', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2652cd8c-5772-4dd4-85ec-efc910ac815e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('93dea3a9-130f-4df9-a088-5296b0c35200', 'dd051d59-5352-4d43-9481-0d66c8f4f718', true, '${role_impersonation}', 'impersonation', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'dd051d59-5352-4d43-9481-0d66c8f4f718', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d386399f-b2db-450a-9e93-8b232152f9f0', '61d68154-ab52-4440-94fe-7b1b07b85c8e', true, '${role_impersonation}', 'impersonation', '245617d4-22a0-4661-9450-5c17c04f2d8c', '61d68154-ab52-4440-94fe-7b1b07b85c8e', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('feef147f-e7d7-43e5-b3f4-02fe6e1bcc4a', '2cf6cede-1b54-493c-afac-0b4582bbb9a2', true, '${role_read-token}', 'read-token', '245617d4-22a0-4661-9450-5c17c04f2d8c', '2cf6cede-1b54-493c-afac-0b4582bbb9a2', NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('17363bd8-ae6f-40df-ae97-b0d9b1e3bcac', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, '${role_offline-access}', 'offline_access', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9b9b2f45-7c7e-4e0d-b06d-8d0f18fd9e14', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, '${role_uma_authorization}', 'uma_authorization', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('edb6d233-6c36-4ef7-bc16-c21cb6445bd3', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, '', 'app_user_role', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('84400dcb-7e86-4666-b93e-9da8c442105b', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, '', 'app_admin_role', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL, NULL);
INSERT INTO keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b45d29fa-f5a9-460e-ac74-815a9aa4642c', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, '', 'app_super_user_role', '245617d4-22a0-4661-9450-5c17c04f2d8c', NULL, NULL);


--
-- TOC entry 4158 (class 0 OID 16613)
-- Dependencies: 257
-- Data for Name: migration_model; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.migration_model (id, version, update_time) VALUES ('u8yhu', '19.0.1', 1662987643);


--
-- TOC entry 4159 (class 0 OID 16617)
-- Dependencies: 258
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4160 (class 0 OID 16624)
-- Dependencies: 259
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4161 (class 0 OID 16630)
-- Dependencies: 260
-- Data for Name: policy_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4162 (class 0 OID 16635)
-- Dependencies: 261
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5d651d57-1388-4943-aa6a-f7b75d763090', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '349835fe-896a-4efb-aa90-794860d9393d', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('43de9082-a7c5-4dbd-ae1d-003cb4fb61db', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '8057dc12-4548-4b3c-abac-d9e569cab7fc', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b3ee798f-4be8-4b76-98b8-16716ab9ad6f', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'ef4c5a4a-3bb9-447b-a121-d9e4e0df61a2');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4ebfa11e-aea6-4eda-ac7f-61d078ee3f97', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c29bd31e-f7c6-4da3-b1b0-246e786b11af', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('10688f5b-44c5-4774-b7e0-f932450d7bc1', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3e5d2d78-d8ea-4a29-8661-a704b8e1fc5a', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('970838ed-283c-4a2d-abdf-8bc298288f26', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('471a3f40-583b-41f3-8924-688b2744d70d', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2c069173-b1ea-4b3d-bbeb-0ca32ec0e689', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('711bf6be-2e85-4743-a015-d30a35bfab5e', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('35565e5f-b691-4868-a652-4765d3943611', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9240eecb-5455-458a-b977-ad1b549dbd2f', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b3d2b749-afb4-48c1-a7e7-ef30ba1f8516', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('38970e05-33aa-48c4-a47b-2e33b551c44c', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2f57e339-5e15-49ec-b264-dc7e51991dab', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e5d1be00-e20f-4a47-9c09-d0705a97fec7', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '77e5519a-977c-49c7-a3d2-9b8751df489b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8adc320b-bf0f-405d-9a55-c2613ca12860', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '64eac5f4-a886-4a0f-b73c-82bdee371ce1');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4e4dabcf-ba15-4d12-8d51-d53b3a230c13', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '64eac5f4-a886-4a0f-b73c-82bdee371ce1');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'ccaf87f0-e112-4b8d-b023-1a0fc84e70e3');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('05cd03ec-2912-4a39-8bf3-ccafd896f038', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3e83b076-747a-4944-b0b0-6ab91598c310');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('11f5e296-750b-4b04-8f30-6ba4bb1f378b', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3e83b076-747a-4944-b0b0-6ab91598c310');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('30894553-f3ce-46df-8d73-b259c99f2eca', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'a5eb6e68-546e-4c85-ae64-105c59f09e81');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7be7328b-cc0c-4e5f-904a-c63b4ffd9511', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'a5eb6e68-546e-4c85-ae64-105c59f09e81');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('74cc6ca6-e88d-478e-bb63-bed0195d05ea', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'a5eb6e68-546e-4c85-ae64-105c59f09e81');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a083c91c-397b-4298-bb96-e71547d9c3bf', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'e6a13fb5-7a68-438c-8dd9-b382541bb59b');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('07705f46-d3c4-4983-a710-08e55d8dcf65', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'dc50d208-626d-445e-a180-9366eb813526');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2400b0ab-d419-4587-a43d-ff111b7f47c9', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'dc50d208-626d-445e-a180-9366eb813526');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0bc8b4d6-e5d7-4b7b-9ff5-c8123d8b69f9', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, '7811627d-08bd-4639-a98a-4d1d7aa8e6d1');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('48434d25-060b-4a80-8d63-39bde6f60e7f', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '8b5e3db7-a356-4f97-aedc-6709aac6899e', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('1de0de1c-59d1-4558-9429-dd160de24caf', 'role list', 'saml', 'saml-role-list-mapper', NULL, '98154b18-1ae7-4c9b-914a-1df601b58711');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b94d70a6-3f6b-43e3-abca-3b9863281d60', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('88633711-3b7e-45ca-882e-58b7a4cecbaa', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e6ef5f0b-02db-44ef-a2f5-9c1acc8c3a8c', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c6c1a3dd-17f8-4a95-8fa7-d346109445bc', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('57b6b9e6-e8f2-408f-b71e-abacd6931e90', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6a23458f-f6be-4314-82e4-e05581ddfbb4', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e94aca46-8e22-460a-b59d-6b8a9e45ad77', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('181deee0-6952-4b04-88ab-660fcd7396b4', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6e94837b-399e-431d-b98f-d062ee49b5ec', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7b5f59a6-a3fb-4488-a6d6-ac8fa6bc3bc2', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8d5747bf-c035-4d0c-8da9-747cd774480e', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e3b68df8-7856-47e8-9454-66176c80f266', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('08bd4c78-864a-41ba-ad19-bafd74986f29', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('06856061-643b-45b8-8651-185c7e24a949', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb8484c0-6abb-4349-b46c-c76542fe4622');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('889cea7f-e9eb-4d98-9da6-7c59ee8d8460', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9183afbd-a103-42bd-a836-cf605a8b196c', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '144f8c8d-c0f2-499f-b3c2-a3a48abcdecd');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '30c23fd3-3cf7-426a-be44-5ed7aa749ad3');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4b1d181b-bfe0-4dfe-8357-58b460b0b533', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('38992d01-b7e9-4e78-b9ab-e82c85fa5fee', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'eb4517ef-9aef-4f18-b4b2-61e9d5c6ece7');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2a5f4f18-5c44-4604-81c0-3df1800735ff', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '47d79312-8b12-4772-9f20-ea1aa297b402');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('d4b332fb-1c34-436c-b551-5e7376ed6f86', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '47d79312-8b12-4772-9f20-ea1aa297b402');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e6971c99-a34c-4159-8b06-f6dd541048b3', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '47d79312-8b12-4772-9f20-ea1aa297b402');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('94ab800c-6f54-4470-8a5d-7c398c1248d0', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '2f9ef4a8-19ed-4ad6-9b4f-4bb7dc65d589');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('108f805e-8c51-4ed2-a598-556866af0d00', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '1b132754-ea05-4574-9742-511d178e37b3');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('318e2e9d-188c-479a-8f12-137e851b2e34', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '1b132754-ea05-4574-9742-511d178e37b3');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b82b0fa4-d8ca-4cdc-a4e6-dc60b9afae58', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'de1986bc-c2d2-4f6e-8186-5ae6307563d0');
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9e1b3812-6a41-4dd2-9c9b-0714bd1a35d5', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '8c80538e-486c-4b9d-87a2-1b034563f1c0', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f0a6e9e5-8bf8-421c-a951-6415297c90eb', 'elastic-query-service', 'openid-connect', 'oidc-audience-mapper', '7a29b352-f4b7-456c-8b46-7d8beaa9bad4', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2ca51948-05eb-413e-ab04-8e9635c260c6', 'client-id', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '7a29b352-f4b7-456c-8b46-7d8beaa9bad4', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('d78b8d54-4240-489c-9e4a-5a19efc9f4df', 'client-host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '7a29b352-f4b7-456c-8b46-7d8beaa9bad4', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5212f0dc-f179-4faa-b3bf-f1a881e26fca', 'client-ip', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '7a29b352-f4b7-456c-8b46-7d8beaa9bad4', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e28b1c30-5e16-4098-90f3-2aad3c5ce50d', 'groups', 'openid-connect', 'oidc-group-membership-mapper', 'cd83868d-d7af-4559-b838-2cf4f4868b93', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('12a3c18f-5fc1-4237-8d9d-1c9f65be605b', 'elastic-query-service', 'openid-connect', 'oidc-audience-mapper', 'cd83868d-d7af-4559-b838-2cf4f4868b93', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('fe9983ac-60da-4ef3-81c0-4600883d27be', 'client-id', 'openid-connect', 'oidc-usersessionmodel-note-mapper', 'cd83868d-d7af-4559-b838-2cf4f4868b93', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('442fd6ef-dde2-49b0-b813-b51ce87798c7', 'client-host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', 'cd83868d-d7af-4559-b838-2cf4f4868b93', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7bc73d31-3322-4280-ba48-3fdc89af312d', 'client-ip', 'openid-connect', 'oidc-usersessionmodel-note-mapper', 'cd83868d-d7af-4559-b838-2cf4f4868b93', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('17680241-5f91-4bbd-a0c6-20e2e6fe73b4', 'microservices-groups', 'openid-connect', 'oidc-group-membership-mapper', '56c92216-f221-49bf-bb61-1333c553624a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('757d919d-609f-4673-b094-a9dff5248021', 'microservices-groups', 'openid-connect', 'oidc-group-membership-mapper', '7a29b352-f4b7-456c-8b46-7d8beaa9bad4', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e59dd65a-214d-40c5-9080-92f008cc27fa', 'kafka-streams-service', 'openid-connect', 'oidc-audience-mapper', '56c92216-f221-49bf-bb61-1333c553624a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ced7f6db-82f7-48c8-85bf-2d1224634f55', 'analytics-service', 'openid-connect', 'oidc-audience-mapper', '56c92216-f221-49bf-bb61-1333c553624a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0cdc434a-df83-48ff-b77b-ab56fcaa69e9', 'client-id', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '56c92216-f221-49bf-bb61-1333c553624a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('770225b9-b8fa-416f-bfa6-df5c84411391', 'client-host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '56c92216-f221-49bf-bb61-1333c553624a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e61a2cac-6302-4864-94d5-8b762203daa1', 'client-ip', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '56c92216-f221-49bf-bb61-1333c553624a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('face0075-04c2-4e86-ab8a-669505441c44', 'client-id', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '9f8490da-40cd-4870-94aa-b37127a2152a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3137fb19-9a5c-4f75-88bb-36c9b1899977', 'kafka-streams-service', 'openid-connect', 'oidc-audience-mapper', '9f8490da-40cd-4870-94aa-b37127a2152a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5a1df7c4-b5a0-432c-8786-1fae7a327879', 'microservices-groups', 'openid-connect', 'oidc-group-membership-mapper', '9f8490da-40cd-4870-94aa-b37127a2152a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a0b742b5-676f-417a-996b-c883c970630f', 'analytics-service', 'openid-connect', 'oidc-audience-mapper', '9f8490da-40cd-4870-94aa-b37127a2152a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8d382cd4-461f-4afc-b549-e29b00a12727', 'client-ip', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '9f8490da-40cd-4870-94aa-b37127a2152a', NULL);
INSERT INTO keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('bf321f25-1863-4bb5-8850-85f810f3f63c', 'client-host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '9f8490da-40cd-4870-94aa-b37127a2152a', NULL);


--
-- TOC entry 4163 (class 0 OID 16640)
-- Dependencies: 262
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43de9082-a7c5-4dbd-ae1d-003cb4fb61db', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43de9082-a7c5-4dbd-ae1d-003cb4fb61db', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43de9082-a7c5-4dbd-ae1d-003cb4fb61db', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43de9082-a7c5-4dbd-ae1d-003cb4fb61db', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43de9082-a7c5-4dbd-ae1d-003cb4fb61db', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('43de9082-a7c5-4dbd-ae1d-003cb4fb61db', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3ee798f-4be8-4b76-98b8-16716ab9ad6f', 'false', 'single');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3ee798f-4be8-4b76-98b8-16716ab9ad6f', 'Basic', 'attribute.nameformat');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3ee798f-4be8-4b76-98b8-16716ab9ad6f', 'Role', 'attribute.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('10688f5b-44c5-4774-b7e0-f932450d7bc1', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('10688f5b-44c5-4774-b7e0-f932450d7bc1', 'firstName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('10688f5b-44c5-4774-b7e0-f932450d7bc1', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('10688f5b-44c5-4774-b7e0-f932450d7bc1', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('10688f5b-44c5-4774-b7e0-f932450d7bc1', 'given_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('10688f5b-44c5-4774-b7e0-f932450d7bc1', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2c069173-b1ea-4b3d-bbeb-0ca32ec0e689', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2c069173-b1ea-4b3d-bbeb-0ca32ec0e689', 'profile', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2c069173-b1ea-4b3d-bbeb-0ca32ec0e689', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2c069173-b1ea-4b3d-bbeb-0ca32ec0e689', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2c069173-b1ea-4b3d-bbeb-0ca32ec0e689', 'profile', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2c069173-b1ea-4b3d-bbeb-0ca32ec0e689', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f57e339-5e15-49ec-b264-dc7e51991dab', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f57e339-5e15-49ec-b264-dc7e51991dab', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f57e339-5e15-49ec-b264-dc7e51991dab', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f57e339-5e15-49ec-b264-dc7e51991dab', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f57e339-5e15-49ec-b264-dc7e51991dab', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f57e339-5e15-49ec-b264-dc7e51991dab', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('35565e5f-b691-4868-a652-4765d3943611', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('35565e5f-b691-4868-a652-4765d3943611', 'website', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('35565e5f-b691-4868-a652-4765d3943611', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('35565e5f-b691-4868-a652-4765d3943611', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('35565e5f-b691-4868-a652-4765d3943611', 'website', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('35565e5f-b691-4868-a652-4765d3943611', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38970e05-33aa-48c4-a47b-2e33b551c44c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38970e05-33aa-48c4-a47b-2e33b551c44c', 'zoneinfo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38970e05-33aa-48c4-a47b-2e33b551c44c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38970e05-33aa-48c4-a47b-2e33b551c44c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38970e05-33aa-48c4-a47b-2e33b551c44c', 'zoneinfo', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38970e05-33aa-48c4-a47b-2e33b551c44c', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e5d2d78-d8ea-4a29-8661-a704b8e1fc5a', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e5d2d78-d8ea-4a29-8661-a704b8e1fc5a', 'middleName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e5d2d78-d8ea-4a29-8661-a704b8e1fc5a', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e5d2d78-d8ea-4a29-8661-a704b8e1fc5a', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e5d2d78-d8ea-4a29-8661-a704b8e1fc5a', 'middle_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e5d2d78-d8ea-4a29-8661-a704b8e1fc5a', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('471a3f40-583b-41f3-8924-688b2744d70d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('471a3f40-583b-41f3-8924-688b2744d70d', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('471a3f40-583b-41f3-8924-688b2744d70d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('471a3f40-583b-41f3-8924-688b2744d70d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('471a3f40-583b-41f3-8924-688b2744d70d', 'preferred_username', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('471a3f40-583b-41f3-8924-688b2744d70d', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebfa11e-aea6-4eda-ac7f-61d078ee3f97', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebfa11e-aea6-4eda-ac7f-61d078ee3f97', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebfa11e-aea6-4eda-ac7f-61d078ee3f97', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('711bf6be-2e85-4743-a015-d30a35bfab5e', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('711bf6be-2e85-4743-a015-d30a35bfab5e', 'picture', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('711bf6be-2e85-4743-a015-d30a35bfab5e', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('711bf6be-2e85-4743-a015-d30a35bfab5e', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('711bf6be-2e85-4743-a015-d30a35bfab5e', 'picture', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('711bf6be-2e85-4743-a015-d30a35bfab5e', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9240eecb-5455-458a-b977-ad1b549dbd2f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9240eecb-5455-458a-b977-ad1b549dbd2f', 'gender', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9240eecb-5455-458a-b977-ad1b549dbd2f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9240eecb-5455-458a-b977-ad1b549dbd2f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9240eecb-5455-458a-b977-ad1b549dbd2f', 'gender', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9240eecb-5455-458a-b977-ad1b549dbd2f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('970838ed-283c-4a2d-abdf-8bc298288f26', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('970838ed-283c-4a2d-abdf-8bc298288f26', 'nickname', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('970838ed-283c-4a2d-abdf-8bc298288f26', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('970838ed-283c-4a2d-abdf-8bc298288f26', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('970838ed-283c-4a2d-abdf-8bc298288f26', 'nickname', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('970838ed-283c-4a2d-abdf-8bc298288f26', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3d2b749-afb4-48c1-a7e7-ef30ba1f8516', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3d2b749-afb4-48c1-a7e7-ef30ba1f8516', 'birthdate', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3d2b749-afb4-48c1-a7e7-ef30ba1f8516', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3d2b749-afb4-48c1-a7e7-ef30ba1f8516', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3d2b749-afb4-48c1-a7e7-ef30ba1f8516', 'birthdate', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b3d2b749-afb4-48c1-a7e7-ef30ba1f8516', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29bd31e-f7c6-4da3-b1b0-246e786b11af', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29bd31e-f7c6-4da3-b1b0-246e786b11af', 'lastName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29bd31e-f7c6-4da3-b1b0-246e786b11af', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29bd31e-f7c6-4da3-b1b0-246e786b11af', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29bd31e-f7c6-4da3-b1b0-246e786b11af', 'family_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c29bd31e-f7c6-4da3-b1b0-246e786b11af', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e5d1be00-e20f-4a47-9c09-d0705a97fec7', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e5d1be00-e20f-4a47-9c09-d0705a97fec7', 'updatedAt', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e5d1be00-e20f-4a47-9c09-d0705a97fec7', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e5d1be00-e20f-4a47-9c09-d0705a97fec7', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e5d1be00-e20f-4a47-9c09-d0705a97fec7', 'updated_at', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e5d1be00-e20f-4a47-9c09-d0705a97fec7', 'long', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4e4dabcf-ba15-4d12-8d51-d53b3a230c13', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4e4dabcf-ba15-4d12-8d51-d53b3a230c13', 'emailVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4e4dabcf-ba15-4d12-8d51-d53b3a230c13', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4e4dabcf-ba15-4d12-8d51-d53b3a230c13', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4e4dabcf-ba15-4d12-8d51-d53b3a230c13', 'email_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4e4dabcf-ba15-4d12-8d51-d53b3a230c13', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8adc320b-bf0f-405d-9a55-c2613ca12860', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8adc320b-bf0f-405d-9a55-c2613ca12860', 'email', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8adc320b-bf0f-405d-9a55-c2613ca12860', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8adc320b-bf0f-405d-9a55-c2613ca12860', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8adc320b-bf0f-405d-9a55-c2613ca12860', 'email', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8adc320b-bf0f-405d-9a55-c2613ca12860', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'formatted', 'user.attribute.formatted');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'country', 'user.attribute.country');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'postal_code', 'user.attribute.postal_code');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'street', 'user.attribute.street');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'region', 'user.attribute.region');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('76a62cfd-ef30-4a8b-98f4-c11274d3dd54', 'locality', 'user.attribute.locality');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('05cd03ec-2912-4a39-8bf3-ccafd896f038', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('05cd03ec-2912-4a39-8bf3-ccafd896f038', 'phoneNumber', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('05cd03ec-2912-4a39-8bf3-ccafd896f038', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('05cd03ec-2912-4a39-8bf3-ccafd896f038', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('05cd03ec-2912-4a39-8bf3-ccafd896f038', 'phone_number', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('05cd03ec-2912-4a39-8bf3-ccafd896f038', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('11f5e296-750b-4b04-8f30-6ba4bb1f378b', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('11f5e296-750b-4b04-8f30-6ba4bb1f378b', 'phoneNumberVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('11f5e296-750b-4b04-8f30-6ba4bb1f378b', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('11f5e296-750b-4b04-8f30-6ba4bb1f378b', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('11f5e296-750b-4b04-8f30-6ba4bb1f378b', 'phone_number_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('11f5e296-750b-4b04-8f30-6ba4bb1f378b', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('30894553-f3ce-46df-8d73-b259c99f2eca', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('30894553-f3ce-46df-8d73-b259c99f2eca', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('30894553-f3ce-46df-8d73-b259c99f2eca', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('30894553-f3ce-46df-8d73-b259c99f2eca', 'realm_access.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('30894553-f3ce-46df-8d73-b259c99f2eca', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7be7328b-cc0c-4e5f-904a-c63b4ffd9511', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7be7328b-cc0c-4e5f-904a-c63b4ffd9511', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7be7328b-cc0c-4e5f-904a-c63b4ffd9511', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7be7328b-cc0c-4e5f-904a-c63b4ffd9511', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7be7328b-cc0c-4e5f-904a-c63b4ffd9511', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('07705f46-d3c4-4983-a710-08e55d8dcf65', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('07705f46-d3c4-4983-a710-08e55d8dcf65', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('07705f46-d3c4-4983-a710-08e55d8dcf65', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('07705f46-d3c4-4983-a710-08e55d8dcf65', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('07705f46-d3c4-4983-a710-08e55d8dcf65', 'upn', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('07705f46-d3c4-4983-a710-08e55d8dcf65', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2400b0ab-d419-4587-a43d-ff111b7f47c9', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2400b0ab-d419-4587-a43d-ff111b7f47c9', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2400b0ab-d419-4587-a43d-ff111b7f47c9', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2400b0ab-d419-4587-a43d-ff111b7f47c9', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2400b0ab-d419-4587-a43d-ff111b7f47c9', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2400b0ab-d419-4587-a43d-ff111b7f47c9', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0bc8b4d6-e5d7-4b7b-9ff5-c8123d8b69f9', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0bc8b4d6-e5d7-4b7b-9ff5-c8123d8b69f9', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1de0de1c-59d1-4558-9429-dd160de24caf', 'false', 'single');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1de0de1c-59d1-4558-9429-dd160de24caf', 'Basic', 'attribute.nameformat');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1de0de1c-59d1-4558-9429-dd160de24caf', 'Role', 'attribute.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06856061-643b-45b8-8651-185c7e24a949', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06856061-643b-45b8-8651-185c7e24a949', 'updatedAt', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06856061-643b-45b8-8651-185c7e24a949', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06856061-643b-45b8-8651-185c7e24a949', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06856061-643b-45b8-8651-185c7e24a949', 'updated_at', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('06856061-643b-45b8-8651-185c7e24a949', 'long', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('08bd4c78-864a-41ba-ad19-bafd74986f29', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('08bd4c78-864a-41ba-ad19-bafd74986f29', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('08bd4c78-864a-41ba-ad19-bafd74986f29', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('08bd4c78-864a-41ba-ad19-bafd74986f29', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('08bd4c78-864a-41ba-ad19-bafd74986f29', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('08bd4c78-864a-41ba-ad19-bafd74986f29', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('181deee0-6952-4b04-88ab-660fcd7396b4', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('181deee0-6952-4b04-88ab-660fcd7396b4', 'picture', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('181deee0-6952-4b04-88ab-660fcd7396b4', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('181deee0-6952-4b04-88ab-660fcd7396b4', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('181deee0-6952-4b04-88ab-660fcd7396b4', 'picture', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('181deee0-6952-4b04-88ab-660fcd7396b4', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57b6b9e6-e8f2-408f-b71e-abacd6931e90', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57b6b9e6-e8f2-408f-b71e-abacd6931e90', 'nickname', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57b6b9e6-e8f2-408f-b71e-abacd6931e90', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57b6b9e6-e8f2-408f-b71e-abacd6931e90', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57b6b9e6-e8f2-408f-b71e-abacd6931e90', 'nickname', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('57b6b9e6-e8f2-408f-b71e-abacd6931e90', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6a23458f-f6be-4314-82e4-e05581ddfbb4', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6a23458f-f6be-4314-82e4-e05581ddfbb4', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6a23458f-f6be-4314-82e4-e05581ddfbb4', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6a23458f-f6be-4314-82e4-e05581ddfbb4', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6a23458f-f6be-4314-82e4-e05581ddfbb4', 'preferred_username', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6a23458f-f6be-4314-82e4-e05581ddfbb4', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6e94837b-399e-431d-b98f-d062ee49b5ec', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6e94837b-399e-431d-b98f-d062ee49b5ec', 'website', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6e94837b-399e-431d-b98f-d062ee49b5ec', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6e94837b-399e-431d-b98f-d062ee49b5ec', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6e94837b-399e-431d-b98f-d062ee49b5ec', 'website', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6e94837b-399e-431d-b98f-d062ee49b5ec', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7b5f59a6-a3fb-4488-a6d6-ac8fa6bc3bc2', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7b5f59a6-a3fb-4488-a6d6-ac8fa6bc3bc2', 'gender', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7b5f59a6-a3fb-4488-a6d6-ac8fa6bc3bc2', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7b5f59a6-a3fb-4488-a6d6-ac8fa6bc3bc2', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7b5f59a6-a3fb-4488-a6d6-ac8fa6bc3bc2', 'gender', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7b5f59a6-a3fb-4488-a6d6-ac8fa6bc3bc2', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('88633711-3b7e-45ca-882e-58b7a4cecbaa', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('88633711-3b7e-45ca-882e-58b7a4cecbaa', 'lastName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('88633711-3b7e-45ca-882e-58b7a4cecbaa', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('88633711-3b7e-45ca-882e-58b7a4cecbaa', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('88633711-3b7e-45ca-882e-58b7a4cecbaa', 'family_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('88633711-3b7e-45ca-882e-58b7a4cecbaa', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d5747bf-c035-4d0c-8da9-747cd774480e', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d5747bf-c035-4d0c-8da9-747cd774480e', 'birthdate', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d5747bf-c035-4d0c-8da9-747cd774480e', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d5747bf-c035-4d0c-8da9-747cd774480e', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d5747bf-c035-4d0c-8da9-747cd774480e', 'birthdate', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d5747bf-c035-4d0c-8da9-747cd774480e', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b94d70a6-3f6b-43e3-abca-3b9863281d60', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b94d70a6-3f6b-43e3-abca-3b9863281d60', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b94d70a6-3f6b-43e3-abca-3b9863281d60', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c6c1a3dd-17f8-4a95-8fa7-d346109445bc', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c6c1a3dd-17f8-4a95-8fa7-d346109445bc', 'middleName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c6c1a3dd-17f8-4a95-8fa7-d346109445bc', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c6c1a3dd-17f8-4a95-8fa7-d346109445bc', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c6c1a3dd-17f8-4a95-8fa7-d346109445bc', 'middle_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c6c1a3dd-17f8-4a95-8fa7-d346109445bc', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e3b68df8-7856-47e8-9454-66176c80f266', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e3b68df8-7856-47e8-9454-66176c80f266', 'zoneinfo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e3b68df8-7856-47e8-9454-66176c80f266', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e3b68df8-7856-47e8-9454-66176c80f266', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e3b68df8-7856-47e8-9454-66176c80f266', 'zoneinfo', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e3b68df8-7856-47e8-9454-66176c80f266', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e6ef5f0b-02db-44ef-a2f5-9c1acc8c3a8c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e6ef5f0b-02db-44ef-a2f5-9c1acc8c3a8c', 'firstName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e6ef5f0b-02db-44ef-a2f5-9c1acc8c3a8c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e6ef5f0b-02db-44ef-a2f5-9c1acc8c3a8c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e6ef5f0b-02db-44ef-a2f5-9c1acc8c3a8c', 'given_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e6ef5f0b-02db-44ef-a2f5-9c1acc8c3a8c', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e94aca46-8e22-460a-b59d-6b8a9e45ad77', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e94aca46-8e22-460a-b59d-6b8a9e45ad77', 'profile', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e94aca46-8e22-460a-b59d-6b8a9e45ad77', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e94aca46-8e22-460a-b59d-6b8a9e45ad77', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e94aca46-8e22-460a-b59d-6b8a9e45ad77', 'profile', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e94aca46-8e22-460a-b59d-6b8a9e45ad77', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('889cea7f-e9eb-4d98-9da6-7c59ee8d8460', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('889cea7f-e9eb-4d98-9da6-7c59ee8d8460', 'email', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('889cea7f-e9eb-4d98-9da6-7c59ee8d8460', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('889cea7f-e9eb-4d98-9da6-7c59ee8d8460', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('889cea7f-e9eb-4d98-9da6-7c59ee8d8460', 'email', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('889cea7f-e9eb-4d98-9da6-7c59ee8d8460', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9183afbd-a103-42bd-a836-cf605a8b196c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9183afbd-a103-42bd-a836-cf605a8b196c', 'emailVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9183afbd-a103-42bd-a836-cf605a8b196c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9183afbd-a103-42bd-a836-cf605a8b196c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9183afbd-a103-42bd-a836-cf605a8b196c', 'email_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9183afbd-a103-42bd-a836-cf605a8b196c', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'formatted', 'user.attribute.formatted');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'country', 'user.attribute.country');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'postal_code', 'user.attribute.postal_code');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'street', 'user.attribute.street');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'region', 'user.attribute.region');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('98f94272-46ad-4a3a-8915-cd3ae3cab53f', 'locality', 'user.attribute.locality');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38992d01-b7e9-4e78-b9ab-e82c85fa5fee', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38992d01-b7e9-4e78-b9ab-e82c85fa5fee', 'phoneNumberVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38992d01-b7e9-4e78-b9ab-e82c85fa5fee', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38992d01-b7e9-4e78-b9ab-e82c85fa5fee', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38992d01-b7e9-4e78-b9ab-e82c85fa5fee', 'phone_number_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('38992d01-b7e9-4e78-b9ab-e82c85fa5fee', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b1d181b-bfe0-4dfe-8357-58b460b0b533', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b1d181b-bfe0-4dfe-8357-58b460b0b533', 'phoneNumber', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b1d181b-bfe0-4dfe-8357-58b460b0b533', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b1d181b-bfe0-4dfe-8357-58b460b0b533', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b1d181b-bfe0-4dfe-8357-58b460b0b533', 'phone_number', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b1d181b-bfe0-4dfe-8357-58b460b0b533', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2a5f4f18-5c44-4604-81c0-3df1800735ff', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2a5f4f18-5c44-4604-81c0-3df1800735ff', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2a5f4f18-5c44-4604-81c0-3df1800735ff', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2a5f4f18-5c44-4604-81c0-3df1800735ff', 'realm_access.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2a5f4f18-5c44-4604-81c0-3df1800735ff', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d4b332fb-1c34-436c-b551-5e7376ed6f86', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d4b332fb-1c34-436c-b551-5e7376ed6f86', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d4b332fb-1c34-436c-b551-5e7376ed6f86', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d4b332fb-1c34-436c-b551-5e7376ed6f86', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d4b332fb-1c34-436c-b551-5e7376ed6f86', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('108f805e-8c51-4ed2-a598-556866af0d00', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('108f805e-8c51-4ed2-a598-556866af0d00', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('108f805e-8c51-4ed2-a598-556866af0d00', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('108f805e-8c51-4ed2-a598-556866af0d00', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('108f805e-8c51-4ed2-a598-556866af0d00', 'upn', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('108f805e-8c51-4ed2-a598-556866af0d00', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('318e2e9d-188c-479a-8f12-137e851b2e34', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('318e2e9d-188c-479a-8f12-137e851b2e34', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('318e2e9d-188c-479a-8f12-137e851b2e34', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('318e2e9d-188c-479a-8f12-137e851b2e34', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('318e2e9d-188c-479a-8f12-137e851b2e34', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('318e2e9d-188c-479a-8f12-137e851b2e34', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b82b0fa4-d8ca-4cdc-a4e6-dc60b9afae58', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b82b0fa4-d8ca-4cdc-a4e6-dc60b9afae58', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9e1b3812-6a41-4dd2-9c9b-0714bd1a35d5', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9e1b3812-6a41-4dd2-9c9b-0714bd1a35d5', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9e1b3812-6a41-4dd2-9c9b-0714bd1a35d5', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9e1b3812-6a41-4dd2-9c9b-0714bd1a35d5', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9e1b3812-6a41-4dd2-9c9b-0714bd1a35d5', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9e1b3812-6a41-4dd2-9c9b-0714bd1a35d5', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0a6e9e5-8bf8-421c-a951-6415297c90eb', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0a6e9e5-8bf8-421c-a951-6415297c90eb', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f0a6e9e5-8bf8-421c-a951-6415297c90eb', 'elastic-query-service', 'included.custom.audience');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ca51948-05eb-413e-ab04-8e9635c260c6', 'clientID', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ca51948-05eb-413e-ab04-8e9635c260c6', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ca51948-05eb-413e-ab04-8e9635c260c6', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ca51948-05eb-413e-ab04-8e9635c260c6', 'clientID', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2ca51948-05eb-413e-ab04-8e9635c260c6', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d78b8d54-4240-489c-9e4a-5a19efc9f4df', 'clientHost', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d78b8d54-4240-489c-9e4a-5a19efc9f4df', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d78b8d54-4240-489c-9e4a-5a19efc9f4df', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d78b8d54-4240-489c-9e4a-5a19efc9f4df', 'clientHost', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('d78b8d54-4240-489c-9e4a-5a19efc9f4df', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5212f0dc-f179-4faa-b3bf-f1a881e26fca', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5212f0dc-f179-4faa-b3bf-f1a881e26fca', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5212f0dc-f179-4faa-b3bf-f1a881e26fca', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5212f0dc-f179-4faa-b3bf-f1a881e26fca', 'clientIPAddress', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5212f0dc-f179-4faa-b3bf-f1a881e26fca', 'clientIPAddress', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28b1c30-5e16-4098-90f3-2aad3c5ce50d', 'false', 'full.path');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28b1c30-5e16-4098-90f3-2aad3c5ce50d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28b1c30-5e16-4098-90f3-2aad3c5ce50d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28b1c30-5e16-4098-90f3-2aad3c5ce50d', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28b1c30-5e16-4098-90f3-2aad3c5ce50d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('12a3c18f-5fc1-4237-8d9d-1c9f65be605b', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('12a3c18f-5fc1-4237-8d9d-1c9f65be605b', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('12a3c18f-5fc1-4237-8d9d-1c9f65be605b', 'elastic-query-service', 'included.custom.audience');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe9983ac-60da-4ef3-81c0-4600883d27be', 'clientID', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe9983ac-60da-4ef3-81c0-4600883d27be', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe9983ac-60da-4ef3-81c0-4600883d27be', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe9983ac-60da-4ef3-81c0-4600883d27be', 'clientID', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('fe9983ac-60da-4ef3-81c0-4600883d27be', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('442fd6ef-dde2-49b0-b813-b51ce87798c7', 'clientHost', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('442fd6ef-dde2-49b0-b813-b51ce87798c7', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('442fd6ef-dde2-49b0-b813-b51ce87798c7', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('442fd6ef-dde2-49b0-b813-b51ce87798c7', 'clientHost', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('442fd6ef-dde2-49b0-b813-b51ce87798c7', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7bc73d31-3322-4280-ba48-3fdc89af312d', 'clientIPAddress', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7bc73d31-3322-4280-ba48-3fdc89af312d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7bc73d31-3322-4280-ba48-3fdc89af312d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7bc73d31-3322-4280-ba48-3fdc89af312d', 'clientIPAddress', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7bc73d31-3322-4280-ba48-3fdc89af312d', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17680241-5f91-4bbd-a0c6-20e2e6fe73b4', 'false', 'full.path');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17680241-5f91-4bbd-a0c6-20e2e6fe73b4', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17680241-5f91-4bbd-a0c6-20e2e6fe73b4', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17680241-5f91-4bbd-a0c6-20e2e6fe73b4', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('17680241-5f91-4bbd-a0c6-20e2e6fe73b4', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('757d919d-609f-4673-b094-a9dff5248021', 'false', 'full.path');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('757d919d-609f-4673-b094-a9dff5248021', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('757d919d-609f-4673-b094-a9dff5248021', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('757d919d-609f-4673-b094-a9dff5248021', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('757d919d-609f-4673-b094-a9dff5248021', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e59dd65a-214d-40c5-9080-92f008cc27fa', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e59dd65a-214d-40c5-9080-92f008cc27fa', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e59dd65a-214d-40c5-9080-92f008cc27fa', 'kafka-streams-service', 'included.custom.audience');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ced7f6db-82f7-48c8-85bf-2d1224634f55', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ced7f6db-82f7-48c8-85bf-2d1224634f55', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ced7f6db-82f7-48c8-85bf-2d1224634f55', 'analytics-service', 'included.custom.audience');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0cdc434a-df83-48ff-b77b-ab56fcaa69e9', 'clientID', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0cdc434a-df83-48ff-b77b-ab56fcaa69e9', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0cdc434a-df83-48ff-b77b-ab56fcaa69e9', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0cdc434a-df83-48ff-b77b-ab56fcaa69e9', 'clientID', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0cdc434a-df83-48ff-b77b-ab56fcaa69e9', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('770225b9-b8fa-416f-bfa6-df5c84411391', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('770225b9-b8fa-416f-bfa6-df5c84411391', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('770225b9-b8fa-416f-bfa6-df5c84411391', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e61a2cac-6302-4864-94d5-8b762203daa1', 'clientIPAddress', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e61a2cac-6302-4864-94d5-8b762203daa1', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e61a2cac-6302-4864-94d5-8b762203daa1', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e61a2cac-6302-4864-94d5-8b762203daa1', 'clientIPAddress', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e61a2cac-6302-4864-94d5-8b762203daa1', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('770225b9-b8fa-416f-bfa6-df5c84411391', 'clientHost', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('770225b9-b8fa-416f-bfa6-df5c84411391', 'clientHost', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3137fb19-9a5c-4f75-88bb-36c9b1899977', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3137fb19-9a5c-4f75-88bb-36c9b1899977', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3137fb19-9a5c-4f75-88bb-36c9b1899977', 'kafka-streams-service', 'included.custom.audience');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5a1df7c4-b5a0-432c-8786-1fae7a327879', 'false', 'full.path');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5a1df7c4-b5a0-432c-8786-1fae7a327879', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5a1df7c4-b5a0-432c-8786-1fae7a327879', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5a1df7c4-b5a0-432c-8786-1fae7a327879', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5a1df7c4-b5a0-432c-8786-1fae7a327879', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d382cd4-461f-4afc-b549-e29b00a12727', 'clientIPAddress', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d382cd4-461f-4afc-b549-e29b00a12727', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d382cd4-461f-4afc-b549-e29b00a12727', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d382cd4-461f-4afc-b549-e29b00a12727', 'clientIPAddress', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d382cd4-461f-4afc-b549-e29b00a12727', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0b742b5-676f-417a-996b-c883c970630f', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0b742b5-676f-417a-996b-c883c970630f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0b742b5-676f-417a-996b-c883c970630f', 'analytics-service', 'included.custom.audience');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bf321f25-1863-4bb5-8850-85f810f3f63c', 'clientHost', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bf321f25-1863-4bb5-8850-85f810f3f63c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bf321f25-1863-4bb5-8850-85f810f3f63c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bf321f25-1863-4bb5-8850-85f810f3f63c', 'clientHost', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bf321f25-1863-4bb5-8850-85f810f3f63c', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bf321f25-1863-4bb5-8850-85f810f3f63c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('face0075-04c2-4e86-ab8a-669505441c44', 'clientID', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('face0075-04c2-4e86-ab8a-669505441c44', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('face0075-04c2-4e86-ab8a-669505441c44', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('face0075-04c2-4e86-ab8a-669505441c44', 'clientID', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('face0075-04c2-4e86-ab8a-669505441c44', 'false', 'access.tokenResponse.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('face0075-04c2-4e86-ab8a-669505441c44', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0b742b5-676f-417a-996b-c883c970630f', 'false', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8d382cd4-461f-4afc-b549-e29b00a12727', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3137fb19-9a5c-4f75-88bb-36c9b1899977', 'false', 'userinfo.token.claim');


--
-- TOC entry 4164 (class 0 OID 16645)
-- Dependencies: 263
-- Data for Name: realm; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'e1c32b88-cebc-4a96-af10-9967ef085c8f', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '58bc45ed-df13-45ee-82a2-a5b2c616b1ee', 'da7df9ba-95ff-4dd8-bde5-9e644adac25c', '836b06ea-d04a-48fa-8a53-e41fcb909a3a', 'efabb7a9-096a-4c4c-a32c-1f1ac70d7f81', '09ae8333-b150-47c5-9d3a-3a7a94fcd937', 2592000, false, 900, true, false, '5777caec-18d6-427d-8fd3-e25f4c842fe2', 0, false, 0, 0, '68f4138d-de4f-4c52-9bf7-b26f5ddd5ddd');
INSERT INTO keycloak.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'microservices_realm', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'dd051d59-5352-4d43-9481-0d66c8f4f718', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '4fdfe572-bcd5-4a09-aae6-0bf5fab07ff2', '1ffc15e4-906f-4487-aec9-6b42b90a3706', 'f106394c-0c73-465c-a44a-a1d98446da2a', '859b567d-b871-4105-ac15-51e11fb4206d', '09b768c0-6bb3-4ab1-9a68-455bc3a215fe', 2592000, false, 900, true, false, '888aaa60-bab6-496e-a7d5-181118a4fb34', 0, false, 0, 0, 'a61a7643-bda4-4d0a-9f5c-89e7af79c6df');


--
-- TOC entry 4165 (class 0 OID 16678)
-- Dependencies: 264
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'nosniff');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'none');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'SAMEORIGIN');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '1; mode=block');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'max-age=31536000; includeSubDomains');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '900');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '60');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '60');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '1000');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '43200');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('failureFactor', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '30');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('displayName', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'Keycloak');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('displayNameHtml', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'RS256');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', '5184000');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', '245617d4-22a0-4661-9450-5c17c04f2d8c', '');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'nosniff');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'none');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'SAMEORIGIN');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', '245617d4-22a0-4661-9450-5c17c04f2d8c', '1; mode=block');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'max-age=31536000; includeSubDomains');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', '245617d4-22a0-4661-9450-5c17c04f2d8c', '900');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', '245617d4-22a0-4661-9450-5c17c04f2d8c', '60');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', '245617d4-22a0-4661-9450-5c17c04f2d8c', '60');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', '245617d4-22a0-4661-9450-5c17c04f2d8c', '1000');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', '245617d4-22a0-4661-9450-5c17c04f2d8c', '43200');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('failureFactor', '245617d4-22a0-4661-9450-5c17c04f2d8c', '30');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'RS256');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', '245617d4-22a0-4661-9450-5c17c04f2d8c', '5184000');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByAdminLifespan', '245617d4-22a0-4661-9450-5c17c04f2d8c', '43200');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByUserLifespan', '245617d4-22a0-4661-9450-5c17c04f2d8c', '300');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('oauth2DeviceCodeLifespan', '245617d4-22a0-4661-9450-5c17c04f2d8c', '600');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('oauth2DevicePollingInterval', '245617d4-22a0-4661-9450-5c17c04f2d8c', '5');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityName', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'keycloak');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithms', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'ES256');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpId', '245617d4-22a0-4661-9450-5c17c04f2d8c', '');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreference', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachment', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKey', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirement', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeout', '245617d4-22a0-4661-9450-5c17c04f2d8c', '0');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityNamePasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'keycloak');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'ES256');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpIdPasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', '');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'not specified');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeoutPasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', '0');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'false');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('cibaBackchannelTokenDeliveryMode', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'poll');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('cibaExpiresIn', '245617d4-22a0-4661-9450-5c17c04f2d8c', '120');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('cibaInterval', '245617d4-22a0-4661-9450-5c17c04f2d8c', '5');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('cibaAuthRequestedUserHint', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'login_hint');
INSERT INTO keycloak.realm_attribute (name, realm_id, value) VALUES ('parRequestUriLifespan', '245617d4-22a0-4661-9450-5c17c04f2d8c', '60');


--
-- TOC entry 4166 (class 0 OID 16683)
-- Dependencies: 265
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4167 (class 0 OID 16686)
-- Dependencies: 266
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4168 (class 0 OID 16689)
-- Dependencies: 267
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.realm_events_listeners (realm_id, value) VALUES ('f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'jboss-logging');
INSERT INTO keycloak.realm_events_listeners (realm_id, value) VALUES ('245617d4-22a0-4661-9450-5c17c04f2d8c', 'jboss-logging');


--
-- TOC entry 4169 (class 0 OID 16692)
-- Dependencies: 268
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4170 (class 0 OID 16697)
-- Dependencies: 269
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8');
INSERT INTO keycloak.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, '245617d4-22a0-4661-9450-5c17c04f2d8c');


--
-- TOC entry 4171 (class 0 OID 16704)
-- Dependencies: 270
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4172 (class 0 OID 16709)
-- Dependencies: 271
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4173 (class 0 OID 16712)
-- Dependencies: 272
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('9dd782c9-5f36-43a9-89a6-45af1332b5f6', '/realms/master/account/*');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '/realms/master/account/*');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '/admin/master/console/*');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('2652cd8c-5772-4dd4-85ec-efc910ac815e', '/realms/microservices_realm/account/*');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '/realms/microservices_realm/account/*');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '/admin/microservices_realm/console/*');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'http://elastic-query-web-client-1:8184/elastic-query-web-client/login/oauth2/code/keycloak');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'http://elastic-query-service-1:8183/elastic-query-service/login/oauth2/code/keycloak');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'http://elastic-query-service-2:8185/elastic-query-service/login/oauth2/code/keycloak');
INSERT INTO keycloak.redirect_uris (client_id, value) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'http://elastic-query-web-client-2:8186/elastic-query-web-client/login/oauth2/code/keycloak');


--
-- TOC entry 4174 (class 0 OID 16715)
-- Dependencies: 273
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4175 (class 0 OID 16720)
-- Dependencies: 274
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('0b1bc1e6-95fd-4e8b-9a38-87b0be6e64a9', 'VERIFY_EMAIL', 'Verify Email', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('9b4867fe-417e-4831-b8f8-2cd59732070f', 'UPDATE_PROFILE', 'Update Profile', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('d39c9c57-4aa8-43af-8741-1060c7834e4d', 'CONFIGURE_TOTP', 'Configure OTP', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('66e5389a-ffc1-4ae0-8b12-923f0dfaeac2', 'UPDATE_PASSWORD', 'Update Password', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('c9f100ec-cf2a-4b2b-be7a-cd7b8c6e8a87', 'terms_and_conditions', 'Terms and Conditions', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', false, false, 'terms_and_conditions', 20);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('062848ea-9141-4420-8f3e-5c261333e584', 'update_user_locale', 'Update User Locale', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', true, false, 'update_user_locale', 1000);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('dac28745-a90a-4fda-932c-2f87d15b22d9', 'delete_account', 'Delete Account', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', false, false, 'delete_account', 60);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('e177833a-b022-4cea-803d-c42963717f6f', 'webauthn-register', 'Webauthn Register', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', true, false, 'webauthn-register', 70);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('c12fc0bd-b187-4f7b-ac57-e028f8570ff6', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('4c4d902e-5f1c-4f50-b1e3-1d59a735cbef', 'VERIFY_EMAIL', 'Verify Email', '245617d4-22a0-4661-9450-5c17c04f2d8c', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('9fd8cdc8-0e9c-44d4-b42b-980b2c8c15ad', 'UPDATE_PROFILE', 'Update Profile', '245617d4-22a0-4661-9450-5c17c04f2d8c', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('fc83d377-1f6c-4ea0-93ba-3cc61c9de593', 'CONFIGURE_TOTP', 'Configure OTP', '245617d4-22a0-4661-9450-5c17c04f2d8c', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('b3c6f66c-2e6b-4c3a-b3aa-d5121622f080', 'UPDATE_PASSWORD', 'Update Password', '245617d4-22a0-4661-9450-5c17c04f2d8c', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('7aaf46c6-9fa2-4201-a905-211d2bd6d8ef', 'terms_and_conditions', 'Terms and Conditions', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, false, 'terms_and_conditions', 20);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('17a2e235-6cfc-470a-9a3d-885497227817', 'update_user_locale', 'Update User Locale', '245617d4-22a0-4661-9450-5c17c04f2d8c', true, false, 'update_user_locale', 1000);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('56d74342-7ebe-475c-8d0b-47927c2da399', 'delete_account', 'Delete Account', '245617d4-22a0-4661-9450-5c17c04f2d8c', false, false, 'delete_account', 60);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('a1ee0620-84a7-4bf9-bccb-7cd6684cf390', 'webauthn-register', 'Webauthn Register', '245617d4-22a0-4661-9450-5c17c04f2d8c', true, false, 'webauthn-register', 70);
INSERT INTO keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('5b7f9b0f-e496-4780-924d-9c0b6010e2d5', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', '245617d4-22a0-4661-9450-5c17c04f2d8c', true, false, 'webauthn-register-passwordless', 80);


--
-- TOC entry 4176 (class 0 OID 16727)
-- Dependencies: 275
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4177 (class 0 OID 16733)
-- Dependencies: 276
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4178 (class 0 OID 16736)
-- Dependencies: 277
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4179 (class 0 OID 16739)
-- Dependencies: 278
-- Data for Name: resource_server; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4180 (class 0 OID 16744)
-- Dependencies: 279
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4181 (class 0 OID 16749)
-- Dependencies: 280
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4182 (class 0 OID 16754)
-- Dependencies: 281
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4183 (class 0 OID 16760)
-- Dependencies: 282
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4184 (class 0 OID 16765)
-- Dependencies: 283
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4185 (class 0 OID 16768)
-- Dependencies: 284
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4186 (class 0 OID 16773)
-- Dependencies: 285
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.scope_mapping (client_id, role_id) VALUES ('349835fe-896a-4efb-aa90-794860d9393d', '28922b05-6c68-4ac9-a432-7e2d767b64d9');
INSERT INTO keycloak.scope_mapping (client_id, role_id) VALUES ('8b5e3db7-a356-4f97-aedc-6709aac6899e', '4f225590-1032-4e44-bdb1-b92d1172b9d3');


--
-- TOC entry 4187 (class 0 OID 16776)
-- Dependencies: 286
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4188 (class 0 OID 16779)
-- Dependencies: 287
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4189 (class 0 OID 16785)
-- Dependencies: 288
-- Data for Name: user_consent; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4190 (class 0 OID 16790)
-- Dependencies: 289
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4191 (class 0 OID 16793)
-- Dependencies: 290
-- Data for Name: user_entity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('d756c1f8-b20d-4e2d-9b51-91aade58a47b', NULL, '6af81321-9646-4a17-a5a0-6e336e48d25c', false, true, NULL, NULL, NULL, 'f6cb1bf1-00ba-4e6d-baf4-a76a44bc81e8', 'admin', 1662987645706, NULL, 0);
INSERT INTO keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('edd8fe96-cf80-4bcf-b39e-7428d83ca4c8', NULL, '0f80b22e-ecb2-4e26-905c-aec98c5cbc29', false, true, NULL, '', '', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'app_user', 1662989210725, NULL, 0);
INSERT INTO keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('e41bd033-77df-4e07-8d38-eb5498998873', NULL, 'bbbe063a-9e2d-490b-8df2-342aed373831', false, true, NULL, '', '', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'app_admin', 1662989225250, NULL, 0);
INSERT INTO keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('388258cb-1542-4104-920d-87e04a0381d5', NULL, '8e80488c-43e2-480d-8eb9-287bd4439551', false, true, NULL, '', '', '245617d4-22a0-4661-9450-5c17c04f2d8c', 'app_super_user', 1662989243519, NULL, 0);


--
-- TOC entry 4192 (class 0 OID 16801)
-- Dependencies: 291
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4193 (class 0 OID 16806)
-- Dependencies: 292
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4194 (class 0 OID 16811)
-- Dependencies: 293
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4195 (class 0 OID 16816)
-- Dependencies: 294
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4196 (class 0 OID 16821)
-- Dependencies: 295
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.user_group_membership (group_id, user_id) VALUES ('b464da35-f538-4413-ab9f-e2428d28b6b0', 'edd8fe96-cf80-4bcf-b39e-7428d83ca4c8');
INSERT INTO keycloak.user_group_membership (group_id, user_id) VALUES ('394ab059-5b9f-4fc5-b4b6-55a164722994', 'e41bd033-77df-4e07-8d38-eb5498998873');
INSERT INTO keycloak.user_group_membership (group_id, user_id) VALUES ('651125c8-1f91-418a-aeb6-d88a1aa8452e', '388258cb-1542-4104-920d-87e04a0381d5');


--
-- TOC entry 4197 (class 0 OID 16824)
-- Dependencies: 296
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4198 (class 0 OID 16828)
-- Dependencies: 297
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('68f4138d-de4f-4c52-9bf7-b26f5ddd5ddd', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('ba30e955-72fe-4b1f-8bfa-8ffdc452e199', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('65ffbfcf-575a-42d1-af1c-7142a5ba3810', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('f61efb0c-413a-47c8-afa5-f591c754deb2', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('77edf79e-7dff-48eb-8d8f-c67d90f0d321', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('91cf5faa-a136-49af-b9dc-a9a41bb5466c', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('310a62db-2127-4ef9-b315-a86acae15f0a', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('f16c357d-1d7e-43e1-bac0-dbe614401413', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('e18e3f51-1384-4039-9fc4-eb9eb740cc07', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('e55b6e4d-8e48-4aa5-8c52-10c2dfd25ad4', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('d70290c8-2efa-46e2-9f1c-38dcbd7e6201', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('60be72e7-f2c9-4bff-adce-8c9b915fe322', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('a2c76fc0-fd2a-4f6d-a799-c52669143d6b', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('9e2d8497-31ed-4f4c-967c-906e7ecf87ee', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('93b47597-f906-436e-bca1-629a91e50cc7', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('781b73e3-ce84-4a39-8757-03a243f52f78', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('d30db0d6-f325-4811-964b-97b488841441', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('c29418a9-95a4-4289-8093-2c5cfaedba3f', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('b53bc85c-21ab-4f6b-b515-9cb28a315770', 'd756c1f8-b20d-4e2d-9b51-91aade58a47b');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', 'edd8fe96-cf80-4bcf-b39e-7428d83ca4c8');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', 'e41bd033-77df-4e07-8d38-eb5498998873');
INSERT INTO keycloak.user_role_mapping (role_id, user_id) VALUES ('a61a7643-bda4-4d0a-9f5c-89e7af79c6df', '388258cb-1542-4104-920d-87e04a0381d5');


--
-- TOC entry 4199 (class 0 OID 16831)
-- Dependencies: 298
-- Data for Name: user_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4200 (class 0 OID 16837)
-- Dependencies: 299
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4201 (class 0 OID 16842)
-- Dependencies: 300
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--



--
-- TOC entry 4202 (class 0 OID 16847)
-- Dependencies: 301
-- Data for Name: web_origins; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

INSERT INTO keycloak.web_origins (client_id, value) VALUES ('8057dc12-4548-4b3c-abac-d9e569cab7fc', '+');
INSERT INTO keycloak.web_origins (client_id, value) VALUES ('8c80538e-486c-4b9d-87a2-1b034563f1c0', '+');
INSERT INTO keycloak.web_origins (client_id, value) VALUES ('7a29b352-f4b7-456c-8b46-7d8beaa9bad4', 'http://elastic-query-web-client-1:8184');
INSERT INTO keycloak.web_origins (client_id, value) VALUES ('56c92216-f221-49bf-bb61-1333c553624a', 'http://elastic-query-service-1:8183');
INSERT INTO keycloak.web_origins (client_id, value) VALUES ('9f8490da-40cd-4870-94aa-b37127a2152a', 'http://elastic-query-service-2:8185');
INSERT INTO keycloak.web_origins (client_id, value) VALUES ('cd83868d-d7af-4559-b838-2cf4f4868b93', 'http://elastic-query-web-client-2:8186');


--
-- TOC entry 3894 (class 2606 OID 16851)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3747 (class 2606 OID 16853)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3634 (class 2606 OID 16855)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3649 (class 2606 OID 16857)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3636 (class 2606 OID 16859)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3782 (class 2606 OID 16861)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3624 (class 2606 OID 16863)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3668 (class 2606 OID 16865)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3674 (class 2606 OID 16867)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3670 (class 2606 OID 16869)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3711 (class 2606 OID 16871)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3693 (class 2606 OID 16873)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3696 (class 2606 OID 16875)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3703 (class 2606 OID 16877)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3707 (class 2606 OID 16879)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3715 (class 2606 OID 16881)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3723 (class 2606 OID 16883)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3784 (class 2606 OID 16885)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3787 (class 2606 OID 16887)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3790 (class 2606 OID 16889)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3799 (class 2606 OID 16891)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3731 (class 2606 OID 16893)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3631 (class 2606 OID 16895)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3690 (class 2606 OID 16897)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3719 (class 2606 OID 16899)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3774 (class 2606 OID 16901)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3666 (class 2606 OID 16903)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3890 (class 2606 OID 16905)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3878 (class 2606 OID 16907)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3662 (class 2606 OID 16909)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3626 (class 2606 OID 16911)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3657 (class 2606 OID 16913)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3844 (class 2606 OID 16915)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3639 (class 2606 OID 16917)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3779 (class 2606 OID 16919)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3795 (class 2606 OID 16921)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3749 (class 2606 OID 16923)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3606 (class 2606 OID 16925)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3622 (class 2606 OID 16927)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3612 (class 2606 OID 16929)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3616 (class 2606 OID 16931)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3619 (class 2606 OID 16933)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3660 (class 2606 OID 16935)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3887 (class 2606 OID 16937)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3677 (class 2606 OID 16939)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3664 (class 2606 OID 16941)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3736 (class 2606 OID 16943)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3766 (class 2606 OID 16945)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3797 (class 2606 OID 16947)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3681 (class 2606 OID 16949)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3870 (class 2606 OID 16951)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3820 (class 2606 OID 16953)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 16955)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 16957)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3609 (class 2606 OID 16959)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3812 (class 2606 OID 16961)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3834 (class 2606 OID 16963)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3815 (class 2606 OID 16965)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3847 (class 2606 OID 16967)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3862 (class 2606 OID 16969)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3876 (class 2606 OID 16971)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3872 (class 2606 OID 16973)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3701 (class 2606 OID 16975)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3859 (class 2606 OID 16977)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3854 (class 2606 OID 16979)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3743 (class 2606 OID 16981)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3725 (class 2606 OID 16983)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3728 (class 2606 OID 16985)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3738 (class 2606 OID 16987)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3741 (class 2606 OID 16989)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3753 (class 2606 OID 16991)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 16993)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3760 (class 2606 OID 16995)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3768 (class 2606 OID 16997)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3772 (class 2606 OID 16999)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3802 (class 2606 OID 17001)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3805 (class 2606 OID 17003)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3807 (class 2606 OID 17005)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3884 (class 2606 OID 17007)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3839 (class 2606 OID 17009)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3841 (class 2606 OID 17011)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3850 (class 2606 OID 17013)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3881 (class 2606 OID 17015)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3892 (class 2606 OID 17017)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3896 (class 2606 OID 17019)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3684 (class 2606 OID 17021)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3647 (class 2606 OID 17023)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3642 (class 2606 OID 17025)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3818 (class 2606 OID 17027)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3655 (class 2606 OID 17029)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3688 (class 2606 OID 17031)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3793 (class 2606 OID 17033)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3810 (class 2606 OID 17035)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3745 (class 2606 OID 17037)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3734 (class 2606 OID 17039)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3629 (class 2606 OID 17041)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3644 (class 2606 OID 17043)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3866 (class 2606 OID 17045)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3832 (class 2606 OID 17047)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3822 (class 2606 OID 17049)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3827 (class 2606 OID 17051)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3837 (class 2606 OID 17053)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3857 (class 2606 OID 17055)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3777 (class 2606 OID 17057)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3868 (class 2606 OID 17059)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3607 (class 1259 OID 17060)
-- Name: idx_admin_event_time; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON keycloak.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3610 (class 1259 OID 17061)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON keycloak.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3620 (class 1259 OID 17062)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON keycloak.authenticator_config USING btree (realm_id);


--
-- TOC entry 3613 (class 1259 OID 17063)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON keycloak.authentication_execution USING btree (flow_id);


--
-- TOC entry 3614 (class 1259 OID 17064)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON keycloak.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3617 (class 1259 OID 17065)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON keycloak.authentication_flow USING btree (realm_id);


--
-- TOC entry 3650 (class 1259 OID 17066)
-- Name: idx_cl_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON keycloak.client_scope_client USING btree (scope_id);


--
-- TOC entry 3632 (class 1259 OID 17067)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON keycloak.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3627 (class 1259 OID 17068)
-- Name: idx_client_id; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_id ON keycloak.client USING btree (client_id);


--
-- TOC entry 3637 (class 1259 OID 17069)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON keycloak.client_initial_access USING btree (realm_id);


--
-- TOC entry 3658 (class 1259 OID 17070)
-- Name: idx_client_session_session; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_session_session ON keycloak.client_session USING btree (session_id);


--
-- TOC entry 3645 (class 1259 OID 17071)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON keycloak.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3651 (class 1259 OID 17072)
-- Name: idx_clscope_cl; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON keycloak.client_scope_client USING btree (client_id);


--
-- TOC entry 3769 (class 1259 OID 17073)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON keycloak.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3652 (class 1259 OID 17074)
-- Name: idx_clscope_role; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_role ON keycloak.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3675 (class 1259 OID 17075)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON keycloak.component_config USING btree (component_id);


--
-- TOC entry 3671 (class 1259 OID 17076)
-- Name: idx_component_provider_type; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON keycloak.component USING btree (provider_type);


--
-- TOC entry 3672 (class 1259 OID 17077)
-- Name: idx_component_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_component_realm ON keycloak.component USING btree (realm_id);


--
-- TOC entry 3678 (class 1259 OID 17078)
-- Name: idx_composite; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_composite ON keycloak.composite_role USING btree (composite);


--
-- TOC entry 3679 (class 1259 OID 17079)
-- Name: idx_composite_child; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_composite_child ON keycloak.composite_role USING btree (child_role);


--
-- TOC entry 3685 (class 1259 OID 17080)
-- Name: idx_defcls_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON keycloak.default_client_scope USING btree (realm_id);


--
-- TOC entry 3686 (class 1259 OID 17081)
-- Name: idx_defcls_scope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON keycloak.default_client_scope USING btree (scope_id);


--
-- TOC entry 3691 (class 1259 OID 17082)
-- Name: idx_event_time; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_event_time ON keycloak.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3720 (class 1259 OID 17083)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON keycloak.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3721 (class 1259 OID 17084)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON keycloak.federated_identity USING btree (user_id);


--
-- TOC entry 3694 (class 1259 OID 17085)
-- Name: idx_fu_attribute; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON keycloak.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3697 (class 1259 OID 17086)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON keycloak.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3698 (class 1259 OID 17087)
-- Name: idx_fu_consent; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_consent ON keycloak.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3699 (class 1259 OID 17088)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON keycloak.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3704 (class 1259 OID 17089)
-- Name: idx_fu_credential; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_credential ON keycloak.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3705 (class 1259 OID 17090)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON keycloak.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3708 (class 1259 OID 17091)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON keycloak.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3709 (class 1259 OID 17092)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON keycloak.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3712 (class 1259 OID 17093)
-- Name: idx_fu_required_action; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON keycloak.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3713 (class 1259 OID 17094)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON keycloak.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3716 (class 1259 OID 17095)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON keycloak.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3717 (class 1259 OID 17096)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON keycloak.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3726 (class 1259 OID 17097)
-- Name: idx_group_attr_group; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON keycloak.group_attribute USING btree (group_id);


--
-- TOC entry 3729 (class 1259 OID 17098)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON keycloak.group_role_mapping USING btree (group_id);


--
-- TOC entry 3739 (class 1259 OID 17099)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON keycloak.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3732 (class 1259 OID 17100)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON keycloak.identity_provider USING btree (realm_id);


--
-- TOC entry 3750 (class 1259 OID 17101)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON keycloak.keycloak_role USING btree (client);


--
-- TOC entry 3751 (class 1259 OID 17102)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON keycloak.keycloak_role USING btree (realm);


--
-- TOC entry 3757 (class 1259 OID 17103)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON keycloak.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3761 (class 1259 OID 17104)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON keycloak.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3762 (class 1259 OID 17105)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON keycloak.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3763 (class 1259 OID 17106)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON keycloak.offline_user_session USING btree (created_on);


--
-- TOC entry 3764 (class 1259 OID 17107)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON keycloak.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3770 (class 1259 OID 17108)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON keycloak.protocol_mapper USING btree (client_id);


--
-- TOC entry 3780 (class 1259 OID 17109)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON keycloak.realm_attribute USING btree (realm_id);


--
-- TOC entry 3640 (class 1259 OID 17110)
-- Name: idx_realm_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON keycloak.client_scope USING btree (realm_id);


--
-- TOC entry 3785 (class 1259 OID 17111)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON keycloak.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3791 (class 1259 OID 17112)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON keycloak.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3788 (class 1259 OID 17113)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON keycloak.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3775 (class 1259 OID 17114)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON keycloak.realm USING btree (master_admin_client);


--
-- TOC entry 3800 (class 1259 OID 17115)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON keycloak.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3803 (class 1259 OID 17116)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON keycloak.redirect_uris USING btree (client_id);


--
-- TOC entry 3808 (class 1259 OID 17117)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON keycloak.required_action_provider USING btree (realm_id);


--
-- TOC entry 3813 (class 1259 OID 17118)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON keycloak.resource_policy USING btree (policy_id);


--
-- TOC entry 3816 (class 1259 OID 17119)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON keycloak.resource_scope USING btree (scope_id);


--
-- TOC entry 3825 (class 1259 OID 17120)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON keycloak.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3830 (class 1259 OID 17121)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON keycloak.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3835 (class 1259 OID 17122)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON keycloak.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3842 (class 1259 OID 17123)
-- Name: idx_role_attribute; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_role_attribute ON keycloak.role_attribute USING btree (role_id);


--
-- TOC entry 3653 (class 1259 OID 17124)
-- Name: idx_role_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_role_clscope ON keycloak.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3845 (class 1259 OID 17125)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON keycloak.scope_mapping USING btree (role_id);


--
-- TOC entry 3848 (class 1259 OID 17126)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON keycloak.scope_policy USING btree (policy_id);


--
-- TOC entry 3754 (class 1259 OID 17127)
-- Name: idx_update_time; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_update_time ON keycloak.migration_model USING btree (update_time);


--
-- TOC entry 3758 (class 1259 OID 17128)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON keycloak.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3860 (class 1259 OID 17129)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON keycloak.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3851 (class 1259 OID 17130)
-- Name: idx_user_attribute; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_attribute ON keycloak.user_attribute USING btree (user_id);


--
-- TOC entry 3852 (class 1259 OID 17131)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON keycloak.user_attribute USING btree (name, value);


--
-- TOC entry 3855 (class 1259 OID 17132)
-- Name: idx_user_consent; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_consent ON keycloak.user_consent USING btree (user_id);


--
-- TOC entry 3682 (class 1259 OID 17133)
-- Name: idx_user_credential; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_credential ON keycloak.credential USING btree (user_id);


--
-- TOC entry 3863 (class 1259 OID 17134)
-- Name: idx_user_email; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_email ON keycloak.user_entity USING btree (email);


--
-- TOC entry 3882 (class 1259 OID 17135)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON keycloak.user_group_membership USING btree (user_id);


--
-- TOC entry 3885 (class 1259 OID 17136)
-- Name: idx_user_reqactions; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON keycloak.user_required_action USING btree (user_id);


--
-- TOC entry 3888 (class 1259 OID 17137)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON keycloak.user_role_mapping USING btree (user_id);


--
-- TOC entry 3864 (class 1259 OID 17138)
-- Name: idx_user_service_account; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_service_account ON keycloak.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3873 (class 1259 OID 17139)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON keycloak.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3874 (class 1259 OID 17140)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON keycloak.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3879 (class 1259 OID 17141)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON keycloak.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3897 (class 1259 OID 17142)
-- Name: idx_web_orig_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON keycloak.web_origins USING btree (client_id);


--
-- TOC entry 3910 (class 2606 OID 17143)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3924 (class 2606 OID 17148)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3904 (class 2606 OID 17153)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3921 (class 2606 OID 17158)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3906 (class 2606 OID 17163)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3911 (class 2606 OID 17168)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3970 (class 2606 OID 17173)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES keycloak.user_session(id);


--
-- TOC entry 3913 (class 2606 OID 17178)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3940 (class 2606 OID 17183)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3966 (class 2606 OID 17188)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3912 (class 2606 OID 17193)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3937 (class 2606 OID 17198)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3942 (class 2606 OID 17203)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3959 (class 2606 OID 17208)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3968 (class 2606 OID 17213)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3928 (class 2606 OID 17218)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES keycloak.realm(id);


--
-- TOC entry 3938 (class 2606 OID 17223)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3933 (class 2606 OID 17228)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3917 (class 2606 OID 17233)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3900 (class 2606 OID 17238)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES keycloak.authentication_flow(id);


--
-- TOC entry 3901 (class 2606 OID 17243)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3902 (class 2606 OID 17248)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3903 (class 2606 OID 17253)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3909 (class 2606 OID 17258)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES keycloak.user_session(id);


--
-- TOC entry 3969 (class 2606 OID 17263)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3907 (class 2606 OID 17268)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3908 (class 2606 OID 17273)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3914 (class 2606 OID 17278)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3930 (class 2606 OID 17283)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3905 (class 2606 OID 17288)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3916 (class 2606 OID 17293)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES keycloak.component(id);


--
-- TOC entry 3915 (class 2606 OID 17298)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3934 (class 2606 OID 17303)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3965 (class 2606 OID 17308)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES keycloak.user_federation_mapper(id);


--
-- TOC entry 3963 (class 2606 OID 17313)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 3964 (class 2606 OID 17318)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3898 (class 2606 OID 17323)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3957 (class 2606 OID 17328)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3947 (class 2606 OID 17333)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3952 (class 2606 OID 17338)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3948 (class 2606 OID 17343)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3949 (class 2606 OID 17348)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3899 (class 2606 OID 17353)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3958 (class 2606 OID 17358)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3950 (class 2606 OID 17363)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3951 (class 2606 OID 17368)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3945 (class 2606 OID 17373)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3943 (class 2606 OID 17378)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3944 (class 2606 OID 17383)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3946 (class 2606 OID 17388)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3953 (class 2606 OID 17393)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3918 (class 2606 OID 17398)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3961 (class 2606 OID 17403)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES keycloak.user_consent(id);


--
-- TOC entry 3960 (class 2606 OID 17408)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3922 (class 2606 OID 17413)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3923 (class 2606 OID 17418)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3935 (class 2606 OID 17423)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3936 (class 2606 OID 17428)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3926 (class 2606 OID 17433)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3927 (class 2606 OID 17438)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES keycloak.identity_provider_mapper(id);


--
-- TOC entry 3971 (class 2606 OID 17443)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3956 (class 2606 OID 17448)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3931 (class 2606 OID 17453)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3919 (class 2606 OID 17458)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3932 (class 2606 OID 17463)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES keycloak.protocol_mapper(id);


--
-- TOC entry 3920 (class 2606 OID 17468)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3941 (class 2606 OID 17473)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3954 (class 2606 OID 17478)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3955 (class 2606 OID 17483)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3939 (class 2606 OID 17488)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3962 (class 2606 OID 17493)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 3967 (class 2606 OID 17498)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3929 (class 2606 OID 17503)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3925 (class 2606 OID 17508)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES keycloak.identity_provider(internal_id);


-- Completed on 2022-09-19 17:24:00 CEST

--
-- PostgreSQL database dump complete
--

