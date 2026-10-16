SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict yIMew1EAd16ecvlYESaOqCojzOgOpVSnBTwOs5QCz3UXIRT8wDqTVbfvEFjniqd

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") VALUES
	('ec7f7310-37df-4be4-b1a9-a33a559a98ad', '174b01f6-3124-42f9-92fe-7d1a4306a858', '3ae375f6-8081-449b-bae0-257ae8d5dc37', 's256', 'z7WAs33u7keDvblv5ULXKD8MRCRIt_HZKEoYGu02d_M', 'magiclink', '', '', '2026-09-18 17:09:18.917343+00', '2026-09-18 17:10:16.460342+00', 'magiclink', '2026-09-18 17:10:16.460296+00', NULL, NULL, NULL, NULL, false),
	('bb5e5077-75eb-497a-8f84-68f8b8ca716c', '174b01f6-3124-42f9-92fe-7d1a4306a858', 'f2747e61-2516-46b7-899b-67623dd3a298', 's256', 'jVIbeVhHxwLYZ0D7rPvl4gtVTxdi9S_Iwj752_MBdow', 'magiclink', '', '', '2026-09-18 17:17:16.93695+00', '2026-09-18 17:17:16.93695+00', 'magiclink', NULL, NULL, NULL, NULL, NULL, false),
	('dbbf146a-300a-4549-91a8-59f4b3093114', '174b01f6-3124-42f9-92fe-7d1a4306a858', '86a86b7b-aab6-46a6-b61a-b19b79cffc6a', 's256', 'soRgNx4Tq-m9XLlWLHiq_6rI2rvFNi36ZDM-f_rSJq0', 'magiclink', '', '', '2026-09-18 17:19:33.114194+00', '2026-09-18 17:19:33.114194+00', 'magiclink', NULL, NULL, NULL, NULL, NULL, false),
	('ae2b6596-3e6e-4971-bf4b-f73f416b3556', '174b01f6-3124-42f9-92fe-7d1a4306a858', '7faef33c-c317-41e3-9171-be1e4b9ff6d2', 's256', 'MosUpb3vjKctqTM9mUI5Op02PM60xWfc5ykm6LdIBiM', 'magiclink', '', '', '2026-09-18 17:27:55.746482+00', '2026-09-18 17:27:55.746482+00', 'magiclink', NULL, NULL, NULL, NULL, NULL, false),
	('68b0ac43-7623-4fda-b181-43797d5e3625', '174b01f6-3124-42f9-92fe-7d1a4306a858', '36aeb61a-cb80-4030-ab67-6cab5036f1ab', 's256', 'zx9ySZVdX5Onj1wEvhrLklfIQ8Mg2iA1_iRrCDbyVa8', 'magiclink', '', '', '2026-09-18 17:35:23.851938+00', '2026-09-18 17:35:23.851938+00', 'magiclink', NULL, NULL, NULL, NULL, NULL, false),
	('2c34e064-615d-46b2-97d1-acfaae8ee035', '174b01f6-3124-42f9-92fe-7d1a4306a858', '64637f21-ccd2-469e-b5c4-4a88b5a3b14e', 's256', 'OLGEBrl8eSe3JoKYDuEXUKtWxcqhsFOlSfvvT3X8Ys4', 'magiclink', '', '', '2026-09-19 18:35:04.928328+00', '2026-09-19 18:35:23.789341+00', 'magiclink', '2026-09-19 18:35:23.789298+00', NULL, NULL, NULL, NULL, false),
	('d080514e-3ffa-4740-8693-d4681a63810d', '174b01f6-3124-42f9-92fe-7d1a4306a858', '6e19920f-049c-46fd-8d89-3409e7782af9', 's256', 'F08MKbooowLxe-I9Ca6utWuG9GY2dud9_Ixax20R2sc', 'magiclink', '', '', '2026-09-19 18:53:41.25448+00', '2026-09-19 18:53:52.986525+00', 'magiclink', '2026-09-19 18:53:52.986478+00', NULL, NULL, NULL, NULL, false),
	('832d586e-959c-4c74-932b-af68a2c8e162', '174b01f6-3124-42f9-92fe-7d1a4306a858', '11e8aa25-b03e-4ac9-b692-4899ac04865c', 's256', '1OesCoNu8IwGLXuvuLVSrJ6HajziCH6RXjgZJrKaTbw', 'magiclink', '', '', '2026-09-19 19:14:20.603542+00', '2026-09-19 19:14:20.603542+00', 'magiclink', NULL, NULL, NULL, NULL, NULL, false),
	('05b3e7e7-64e7-4bda-a32b-db6f410c924e', '174b01f6-3124-42f9-92fe-7d1a4306a858', '76c31dbe-fbb4-4301-ac7d-1bac6faac4d1', 's256', 'JnXCZ0Lk61myqvvBKYaE7bhvAte11e3mtOaI_LQGV1Q', 'magiclink', '', '', '2026-09-19 19:14:40.077949+00', '2026-09-19 19:14:40.077949+00', 'magiclink', NULL, NULL, NULL, NULL, NULL, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 'authenticated', 'authenticated', 'tom@gmail.com', '$2a$10$60IsHkkFYVsLH9ZSZFAl8up620pfqVhisG9A8eshZx0LL80b.womG', '2026-08-21 20:30:29.159865+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-08-21 20:30:29.144493+00', '2026-08-21 20:30:29.160904+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '174b01f6-3124-42f9-92fe-7d1a4306a858', 'authenticated', 'authenticated', 'torimeister@gmail.com', '$2a$10$zf2AGq1W5u3rorPljKxFNOkFgkHH.P/es.orDL72kd/N04k3qEzoG', '2026-09-13 21:01:12.57758+00', NULL, '', NULL, '', '2026-09-19 18:53:41.274667+00', '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-09-13 21:01:12.543902+00', '2026-09-19 18:53:52.983694+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', '{"sub": "2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2", "email": "tom@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2026-08-21 20:30:29.155608+00', '2026-08-21 20:30:29.155656+00', '2026-08-21 20:30:29.155656+00', '128b7965-5a6f-4bc4-a095-425e11d6590b'),
	('174b01f6-3124-42f9-92fe-7d1a4306a858', '174b01f6-3124-42f9-92fe-7d1a4306a858', '{"sub": "174b01f6-3124-42f9-92fe-7d1a4306a858", "email": "torimeister@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2026-09-13 21:01:12.567343+00', '2026-09-13 21:01:12.567395+00', '2026-09-13 21:01:12.567395+00', 'da320bec-dfb7-4f6b-8fad-0a287e0b28ec');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_recovery_code_sets; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_recovery_codes; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: scim_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: scim_users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."categories" ("id", "name", "created_at") VALUES
	('388ba354-ab93-4602-b4ff-9ab66c80aa59', 'Salary', '2026-08-21 20:22:50.915493+00'),
	('64544fc3-966a-4fda-a376-c1421d1be2ed', 'Food', '2026-08-21 20:22:50.915493+00'),
	('55406f87-98a8-45e4-8f8b-92505e9d17d9', 'Transport', '2026-08-21 20:22:50.915493+00'),
	('758cef67-7a13-4aaf-b449-e7db66854d88', 'Shopping', '2026-08-21 20:22:50.915493+00'),
	('356fb44b-49e5-4425-9f62-f8835886ae50', 'Savings', '2026-08-21 20:22:50.915493+00');


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."transactions" ("id", "user_id", "amount", "type", "category_id", "description", "transaction_date", "created_at") VALUES
	('5465ce54-a2c3-4e72-9fa2-9d46799bc362', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 1000.34, 'expense', '64544fc3-966a-4fda-a376-c1421d1be2ed', 'Groceries in EKO Market', '2026-08-21', '2026-08-21 20:37:59.828829+00'),
	('aa7535ec-ed35-4ae1-abfa-33a6733bf44d', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 450.00, 'expense', '64544fc3-966a-4fda-a376-c1421d1be2ed', 'Lunch at restaurant', '2026-08-20', '2026-08-25 08:48:27.166095+00'),
	('0c02d6be-d44b-4311-be1a-c81285f4d6cc', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 320.00, 'expense', '55406f87-98a8-45e4-8f8b-92505e9d17d9', 'Taxi', '2026-08-19', '2026-08-25 08:48:27.166095+00'),
	('6bf94c76-fcd1-467b-9d51-57222936f9a0', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 5000.00, 'income', '388ba354-ab93-4602-b4ff-9ab66c80aa59', 'Freelance payment', '2026-08-15', '2026-08-25 08:48:27.166095+00'),
	('4604e1cf-4ebe-4023-9188-3e0d6ab55e14', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 780.50, 'expense', '64544fc3-966a-4fda-a376-c1421d1be2ed', 'Supermarket', '2026-08-14', '2026-08-25 08:48:27.166095+00'),
	('e4375279-c34b-4ea4-bc94-6959d6dfee7d', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 5600.00, 'income', '388ba354-ab93-4602-b4ff-9ab66c80aa59', 'Salary from home', '2026-09-08', '2026-09-08 10:34:06.561+00'),
	('e9b8631d-1a76-49c6-b91d-d204ab1775c9', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 3456.00, 'expense', '758cef67-7a13-4aaf-b449-e7db66854d88', 'Buy shoes', '2026-09-08', '2026-09-08 10:45:28.354+00'),
	('69236111-a802-4ecb-b110-d174ef6a4087', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 20.00, 'income', '55406f87-98a8-45e4-8f8b-92505e9d17d9', 'Bus', '2026-09-08', '2026-09-08 10:49:06.892+00'),
	('4bafb714-a6b0-4407-848d-0e05248ed281', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 134.00, 'expense', '64544fc3-966a-4fda-a376-c1421d1be2ed', 'Buy ice-crem', '2026-09-08', '2026-09-08 11:09:57.479+00'),
	('46f8fddd-0a12-439c-bb22-37ab7a12bec7', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 1608.00, 'expense', '64544fc3-966a-4fda-a376-c1421d1be2ed', 'Buy food', '2026-09-05', '2026-09-08 11:14:54.581+00'),
	('075a99e2-af9e-4a77-a428-992638d96ae6', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 400.00, 'income', '356fb44b-49e5-4425-9f62-f8835886ae50', 'Sold flower', '2026-09-08', '2026-09-08 11:18:58.452+00'),
	('19ddd2f9-9ed0-4694-9aff-bf0b1f79c1c5', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 50.00, 'income', '55406f87-98a8-45e4-8f8b-92505e9d17d9', 'bus', '2026-09-08', '2026-09-08 14:11:14.461+00'),
	('2de8fc27-32de-4993-aac7-5e69aace2c75', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 3688.00, 'expense', '64544fc3-966a-4fda-a376-c1421d1be2ed', 'Buy some tasty food', '2026-09-09', '2026-09-09 09:13:51.98+00'),
	('8d24b357-e0ec-40c8-9159-e2cc280910f2', '2b2e1af2-fa26-4d63-9cd3-3fa50d6507d2', 1055.00, 'expense', '64544fc3-966a-4fda-a376-c1421d1be2ed', 'good chef bowls', '2026-09-13', '2026-09-13 20:24:34.489+00');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict yIMew1EAd16ecvlYESaOqCojzOgOpVSnBTwOs5QCz3UXIRT8wDqTVbfvEFjniqd

RESET ALL;
