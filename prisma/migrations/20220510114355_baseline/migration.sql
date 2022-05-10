--
-- PostgreSQL database dump
--

-- Dumped from database version 10.18
-- Dumped by pg_dump version 14.2

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
-- Name: error-handling-prod; Type: SCHEMA; Schema: -; Owner: prisma
--

-- CREATE SCHEMA "error-handling-prod";


-- ALTER SCHEMA "error-handling-prod" OWNER TO prisma;

--
-- Name: ErrorArea; Type: TYPE; Schema: error-handling-prod; Owner: prisma
--

CREATE TYPE "error-handling-prod"."ErrorArea" AS ENUM (
    'INTROSPECTION_CLI',
    'LIFT_CLI',
    'PHOTON_STUDIO'
);


ALTER TYPE "error-handling-prod"."ErrorArea" OWNER TO prisma;

--
-- Name: ErrorKind; Type: TYPE; Schema: error-handling-prod; Owner: prisma
--

CREATE TYPE "error-handling-prod"."ErrorKind" AS ENUM (
    'JS_ERROR',
    'RUST_PANIC'
);


ALTER TYPE "error-handling-prod"."ErrorKind" OWNER TO prisma;

--
-- Name: ReportState; Type: TYPE; Schema: error-handling-prod; Owner: prisma
--

CREATE TYPE "error-handling-prod"."ReportState" AS ENUM (
    'Archived',
    'Blocked',
    'Duplicate',
    'NeedsInfo',
    'New',
    'Ready',
    'Resovled'
);


ALTER TYPE "error-handling-prod"."ReportState" OWNER TO prisma;

SET default_tablespace = '';

--
-- Name: Comment; Type: TABLE; Schema: error-handling-prod; Owner: prisma
--

CREATE TABLE "error-handling-prod"."Comment" (
    id text NOT NULL,
    message text NOT NULL,
    "errorReportId" integer
);


ALTER TABLE "error-handling-prod"."Comment" OWNER TO prisma;

--
-- Name: ErrorReport; Type: TABLE; Schema: error-handling-prod; Owner: prisma
--

CREATE TABLE "error-handling-prod"."ErrorReport" (
    "cliVersion" text NOT NULL,
    "binaryVersion" text NOT NULL,
    command text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    ip text NOT NULL,
    kind "error-handling-prod"."ErrorKind" NOT NULL,
    "operatingSystem" text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "zipUploaded" boolean DEFAULT false NOT NULL,
    "zipUrl" text NOT NULL,
    "signedUrl" text NOT NULL,
    "schemaFile" text,
    area "error-handling-prod"."ErrorArea" NOT NULL,
    "jsStackTrace" text NOT NULL,
    "liftRequest" text,
    platform text NOT NULL,
    "rustStackTrace" text NOT NULL,
    fingerprint text,
    description text,
    "issueUrl" text,
    "sqlDump" text,
    "reportState" "error-handling-prod"."ReportState" DEFAULT 'New'::"error-handling-prod"."ReportState" NOT NULL,
    "dbVersion" text
);


ALTER TABLE "error-handling-prod"."ErrorReport" OWNER TO prisma;

--
-- Name: ErrorReport_id_seq; Type: SEQUENCE; Schema: error-handling-prod; Owner: prisma
--

CREATE SEQUENCE "error-handling-prod"."ErrorReport_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "error-handling-prod"."ErrorReport_id_seq" OWNER TO prisma;

--
-- Name: ErrorReport_id_seq; Type: SEQUENCE OWNED BY; Schema: error-handling-prod; Owner: prisma
--

ALTER SEQUENCE "error-handling-prod"."ErrorReport_id_seq" OWNED BY "error-handling-prod"."ErrorReport".id;


--
-- Name: User; Type: TABLE; Schema: error-handling-prod; Owner: prisma
--

CREATE TABLE "error-handling-prod"."User" (
    email text NOT NULL,
    id text NOT NULL,
    password text NOT NULL
);


ALTER TABLE "error-handling-prod"."User" OWNER TO prisma;

--
-- Name: _Migration; Type: TABLE; Schema: error-handling-prod; Owner: prisma
--

CREATE TABLE "error-handling-prod"."_Migration" (
    revision integer NOT NULL,
    name text NOT NULL,
    datamodel text NOT NULL,
    status text NOT NULL,
    applied integer NOT NULL,
    rolled_back integer NOT NULL,
    datamodel_steps text NOT NULL,
    database_migration text NOT NULL,
    errors text NOT NULL,
    started_at timestamp(3) without time zone NOT NULL,
    finished_at timestamp(3) without time zone
);


ALTER TABLE "error-handling-prod"."_Migration" OWNER TO prisma;

--
-- Name: _Migration_revision_seq; Type: SEQUENCE; Schema: error-handling-prod; Owner: prisma
--

CREATE SEQUENCE "error-handling-prod"."_Migration_revision_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "error-handling-prod"."_Migration_revision_seq" OWNER TO prisma;

--
-- Name: _Migration_revision_seq; Type: SEQUENCE OWNED BY; Schema: error-handling-prod; Owner: prisma
--

ALTER SEQUENCE "error-handling-prod"."_Migration_revision_seq" OWNED BY "error-handling-prod"."_Migration".revision;


--
-- Name: ErrorReport id; Type: DEFAULT; Schema: error-handling-prod; Owner: prisma
--

ALTER TABLE ONLY "error-handling-prod"."ErrorReport" ALTER COLUMN id SET DEFAULT nextval('"error-handling-prod"."ErrorReport_id_seq"'::regclass);


--
-- Name: _Migration revision; Type: DEFAULT; Schema: error-handling-prod; Owner: prisma
--

ALTER TABLE ONLY "error-handling-prod"."_Migration" ALTER COLUMN revision SET DEFAULT nextval('"error-handling-prod"."_Migration_revision_seq"'::regclass);


--
-- Name: Comment Comment_pkey; Type: CONSTRAINT; Schema: error-handling-prod; Owner: prisma
--

ALTER TABLE ONLY "error-handling-prod"."Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (id);


--
-- Name: ErrorReport ErrorReport_pkey; Type: CONSTRAINT; Schema: error-handling-prod; Owner: prisma
--

ALTER TABLE ONLY "error-handling-prod"."ErrorReport"
    ADD CONSTRAINT "ErrorReport_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: error-handling-prod; Owner: prisma
--

ALTER TABLE ONLY "error-handling-prod"."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _Migration _Migration_pkey; Type: CONSTRAINT; Schema: error-handling-prod; Owner: prisma
--

ALTER TABLE ONLY "error-handling-prod"."_Migration"
    ADD CONSTRAINT "_Migration_pkey" PRIMARY KEY (revision);


--
-- Name: ErrorReport.signedUrl_unique; Type: INDEX; Schema: error-handling-prod; Owner: prisma
--

CREATE UNIQUE INDEX "ErrorReport.signedUrl_unique" ON "error-handling-prod"."ErrorReport" USING btree ("signedUrl");


--
-- Name: ErrorReport.zipUrl_unique; Type: INDEX; Schema: error-handling-prod; Owner: prisma
--

CREATE UNIQUE INDEX "ErrorReport.zipUrl_unique" ON "error-handling-prod"."ErrorReport" USING btree ("zipUrl");


--
-- Name: User.email_unique; Type: INDEX; Schema: error-handling-prod; Owner: prisma
--

CREATE UNIQUE INDEX "User.email_unique" ON "error-handling-prod"."User" USING btree (email);


--
-- Name: error_report_jsstacktrace_index; Type: INDEX; Schema: error-handling-prod; Owner: prisma
--

CREATE INDEX error_report_jsstacktrace_index ON "error-handling-prod"."ErrorReport" USING gin (to_tsvector('simple'::regconfig, "jsStackTrace"));


--
-- Name: error_report_ruststacktrace_index; Type: INDEX; Schema: error-handling-prod; Owner: prisma
--

CREATE INDEX error_report_ruststacktrace_index ON "error-handling-prod"."ErrorReport" USING gin (to_tsvector('simple'::regconfig, "rustStackTrace"));


--
-- Name: Comment Comment_errorReportId_fkey; Type: FK CONSTRAINT; Schema: error-handling-prod; Owner: prisma
--

ALTER TABLE ONLY "error-handling-prod"."Comment"
    ADD CONSTRAINT "Comment_errorReportId_fkey" FOREIGN KEY ("errorReportId") REFERENCES "error-handling-prod"."ErrorReport"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

