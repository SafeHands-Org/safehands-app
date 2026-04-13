SET session_replication_role = replica;

INSERT INTO public.families VALUES
('c8fb062a-ca7a-44e8-9850-71a17dd0cc2f', 'Awesome Family', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.86273');

INSERT INTO public.family_member_medications VALUES
	('7744d33e-1d05-4326-b44f-e76df430b08b', 'b1c75884-aa8e-4e99-a269-e0e3c49afefb', 'f284575f-7faa-41f3-bbd7-e10545fca48c', 'high', 1, false),
	('3858d22a-52e5-444c-ad3a-c3b089bf1dce', '718aa7f1-6c63-48e8-b35d-c3a8e8875797', 'f284575f-7faa-41f3-bbd7-e10545fca48c', 'high', 1, true),
	('16d3d420-3cea-4c76-9f64-aa010f8658a2', '2201b528-dc58-41ad-84e0-adac2d9e47fd', 'f284575f-7faa-41f3-bbd7-e10545fca48c', 'medium', 1, true),
	('85236c48-8f0f-4593-834f-bad23e3ab514', 'b0ef5e45-9165-4c69-90a5-78b45691771b', 'a7258dab-e897-4b7a-beb7-ad98f7d667bf', 'low', 2, false),
	('94b912b3-34b6-419a-8e5a-5d3cd3c2e340', 'bbfdff04-871d-4a3b-8524-6c2875174d05', 'a7258dab-e897-4b7a-beb7-ad98f7d667bf', 'high', 1, true),
	('cd3fe22c-27b0-4c27-912a-632cc49098bc', '58fc59bd-7d95-470d-a756-0c3786fc835c', 'a7258dab-e897-4b7a-beb7-ad98f7d667bf', 'medium', 1, true),
	('d9f04e7f-49ef-45f6-962b-ca9b1de1553a', '1a592997-9614-4586-b0c0-6c73431a8871', 'a0607f7a-b342-47a9-80ce-808c178c6b15', 'high', 2, true),
	('81f4f01f-ee52-433d-9f70-9eb4c5c719f8', 'd8a0f8a1-80d3-4ffa-aa0e-d5cccc44e0e0', 'a0607f7a-b342-47a9-80ce-808c178c6b15', 'medium', 1, false),
	('36cb5f4a-fd5e-4fc7-ac6a-172075ccda76', '500228dc-fb08-4c74-8835-d16d61163287', 'a0607f7a-b342-47a9-80ce-808c178c6b15', 'low', 3, true),
	('90e25a15-9daf-4e12-aced-cdda06c4cff0', 'a26e53b3-8663-412b-84a7-64f41cc31528', 'ad16f887-7039-4ece-9e25-7a3474b6c782', 'high', 2, true),
	('38b62360-6844-4129-9bcd-93563c0225d2', 'b0ef5e45-9165-4c69-90a5-78b45691771b', 'ad16f887-7039-4ece-9e25-7a3474b6c782', 'low', 2, false),
	('262ef538-e0e5-4536-a24a-c01306a1f7c9', 'd8a0f8a1-80d3-4ffa-aa0e-d5cccc44e0e0', 'ad16f887-7039-4ece-9e25-7a3474b6c782', 'medium', 1, true);

INSERT INTO public.family_memberships VALUES
	('f284575f-7faa-41f3-bbd7-e10545fca48c', '0432ab9c-eedc-421f-8903-dc4f70b513a3', 'c8fb062a-ca7a-44e8-9850-71a17dd0cc2f', 'high', false, '2026-04-01 20:52:50.864102'),
	('a7258dab-e897-4b7a-beb7-ad98f7d667bf', 'b83f2a7f-855c-4c75-863d-9346e6eb90ea', 'c8fb062a-ca7a-44e8-9850-71a17dd0cc2f', 'medium', false, '2026-04-01 20:52:50.864102'),
	('a0607f7a-b342-47a9-80ce-808c178c6b15', '652874de-4077-4ed2-8318-ceb4071ee25b', 'c8fb062a-ca7a-44e8-9850-71a17dd0cc2f', 'low', false, '2026-04-01 20:52:50.864102'),
	('ad16f887-7039-4ece-9e25-7a3474b6c782', '865b91ae-da7f-413d-af4c-d281183280ac', 'c8fb062a-ca7a-44e8-9850-71a17dd0cc2f', 'low', false, '2026-04-01 20:52:50.864102');

INSERT INTO public.medication_adherence_logs VALUES
	('69007ea4-24a7-417e-98a5-0d2ef11dbaaa', '7744d33e-1d05-4326-b44f-e76df430b08b', '08:00:00', '2026-01-05 08:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('0d7d09f2-a011-4e57-8b77-81ae48980f79', '7744d33e-1d05-4326-b44f-e76df430b08b', '14:00:00', '2026-01-12 14:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f87efcd2-96c8-4f40-9604-70218dfc50f7', '7744d33e-1d05-4326-b44f-e76df430b08b', '20:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('18abdaa6-470a-4000-8364-4579de4e30ab', '7744d33e-1d05-4326-b44f-e76df430b08b', '08:00:00', '2026-02-10 08:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('731498a4-684d-4972-b25e-b9cda8257e64', '7744d33e-1d05-4326-b44f-e76df430b08b', '14:00:00', '2026-02-25 14:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('a41bd2ea-82d7-4dbe-8888-c14536f4c572', '3858d22a-52e5-444c-ad3a-c3b089bf1dce', '09:00:00', '2026-03-10 09:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f719a0d4-94ab-4343-98eb-149c943b3bc7', '3858d22a-52e5-444c-ad3a-c3b089bf1dce', '09:00:00', '2026-03-11 09:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('b49e026f-ec04-496c-8e31-1969458ed49b', '3858d22a-52e5-444c-ad3a-c3b089bf1dce', '09:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f13a20d2-b3cc-4e45-ac7e-d38f17d95900', '3858d22a-52e5-444c-ad3a-c3b089bf1dce', '09:00:00', '2026-03-13 09:02:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('ca94f141-9631-47e1-94e7-8e776c286106', '3858d22a-52e5-444c-ad3a-c3b089bf1dce', '09:00:00', '2026-03-14 09:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('e1b5f8ac-02b6-43c1-aa95-0894fd4f2f99', '16d3d420-3cea-4c76-9f64-aa010f8658a2', '08:00:00', '2026-03-10 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('3e60c0eb-1a7b-4efb-9a9d-485947676786', '16d3d420-3cea-4c76-9f64-aa010f8658a2', '08:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f14c26bc-c88b-4c16-8fa7-395c180026fa', '16d3d420-3cea-4c76-9f64-aa010f8658a2', '08:00:00', '2026-03-12 08:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('a939ea5d-dce0-4aad-bf2a-b6d8e49c430d', '16d3d420-3cea-4c76-9f64-aa010f8658a2', '08:00:00', '2026-03-13 08:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('b4d95610-3573-4379-a7bc-420dcaba6953', '16d3d420-3cea-4c76-9f64-aa010f8658a2', '08:00:00', '2026-03-14 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f7b16505-2d82-4b5d-b2e5-f140bc146dd0', '85236c48-8f0f-4593-834f-bad23e3ab514', '08:00:00', '2026-01-16 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('2ece7c7e-abe2-4a85-8f2c-8afdd87772db', '85236c48-8f0f-4593-834f-bad23e3ab514', '20:00:00', '2026-01-20 20:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('04cd1132-b8be-4406-89a9-8bf4eef275aa', '85236c48-8f0f-4593-834f-bad23e3ab514', '08:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('13fadb2e-e867-4318-8b2e-df729367dc7b', '85236c48-8f0f-4593-834f-bad23e3ab514', '20:00:00', '2026-02-05 20:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('9aede706-4b06-4fa0-b9c8-30d59c66f826', '85236c48-8f0f-4593-834f-bad23e3ab514', '08:00:00', '2026-02-14 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f5224ab3-013c-4f87-92f7-89d5df78f1a7', '94b912b3-34b6-419a-8e5a-5d3cd3c2e340', '07:00:00', '2026-03-10 07:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('db3da0cb-133c-4637-aafd-60636c037c36', '94b912b3-34b6-419a-8e5a-5d3cd3c2e340', '07:00:00', '2026-03-11 07:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('3c5a4f68-1470-4d68-b0d7-b94443782193', '94b912b3-34b6-419a-8e5a-5d3cd3c2e340', '07:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('988aa84e-e210-4eb5-9c82-3edb6df6898d', '94b912b3-34b6-419a-8e5a-5d3cd3c2e340', '07:00:00', '2026-03-13 07:03:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('ff606862-5d16-4fdf-9d30-4a51da06fcf4', '94b912b3-34b6-419a-8e5a-5d3cd3c2e340', '07:00:00', '2026-03-14 07:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('62e10951-6332-4a61-9eec-85fa86b25474', 'cd3fe22c-27b0-4c27-912a-632cc49098bc', '07:30:00', '2026-03-10 07:35:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('c0892d9c-9c9e-4add-b989-f0d6300a6958', 'cd3fe22c-27b0-4c27-912a-632cc49098bc', '07:30:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f96ca13c-993f-4e97-8104-ac49f795befd', 'cd3fe22c-27b0-4c27-912a-632cc49098bc', '07:30:00', '2026-03-12 07:30:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('b4d0b927-ac43-466f-bff0-4d07bf17c93b', 'cd3fe22c-27b0-4c27-912a-632cc49098bc', '07:30:00', '2026-03-13 07:40:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('64646710-3139-4015-84b5-6653efcc960a', 'cd3fe22c-27b0-4c27-912a-632cc49098bc', '07:30:00', '2026-03-14 07:30:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('85a8bf15-f085-4d24-a502-c2c08556379d', 'd9f04e7f-49ef-45f6-962b-ca9b1de1553a', '08:00:00', '2026-03-10 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('703ea00c-7c99-4fe2-8b60-4f2dec09b932', 'd9f04e7f-49ef-45f6-962b-ca9b1de1553a', '08:00:00', '2026-03-11 08:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('ca59b18a-586e-453b-8915-8bfa986233f9', 'd9f04e7f-49ef-45f6-962b-ca9b1de1553a', '08:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('b001bf0b-b0a7-430b-b529-de0078a666cd', 'd9f04e7f-49ef-45f6-962b-ca9b1de1553a', '08:00:00', '2026-03-13 08:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('914318bc-d4bc-45be-9d43-d855d7ca57c1', 'd9f04e7f-49ef-45f6-962b-ca9b1de1553a', '08:00:00', '2026-03-14 08:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('2b5ccd45-0301-4dbc-a86a-3328d168b4d3', '81f4f01f-ee52-433d-9f70-9eb4c5c719f8', '09:00:00', '2026-01-12 09:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('e4d2ae44-258f-4503-bcae-ac42481b2f67', '81f4f01f-ee52-433d-9f70-9eb4c5c719f8', '09:00:00', '2026-01-20 09:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('a9c9e4b2-aa95-4c1d-a54b-b5e9c3d09253', '81f4f01f-ee52-433d-9f70-9eb4c5c719f8', '09:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('48c4776c-8d4d-4ede-a1c9-d9293fec5ff1', '81f4f01f-ee52-433d-9f70-9eb4c5c719f8', '09:00:00', '2026-02-10 09:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('f86144b6-1f22-4a79-8114-0238bf2cb4d1', '81f4f01f-ee52-433d-9f70-9eb4c5c719f8', '09:00:00', '2026-02-27 09:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('458b4191-746f-48eb-b767-d5baa2089b71', '36cb5f4a-fd5e-4fc7-ac6a-172075ccda76', '08:00:00', '2026-03-07 08:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('173c72a9-7b98-4647-bab8-a21705545cd4', '36cb5f4a-fd5e-4fc7-ac6a-172075ccda76', '08:00:00', '2026-03-08 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('7a3a299b-d88c-4d43-9391-9608284a4c5b', '36cb5f4a-fd5e-4fc7-ac6a-172075ccda76', '08:00:00', '2026-03-09 08:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('7ffd529c-c0e2-4d8d-be39-989f7ecaf01b', '36cb5f4a-fd5e-4fc7-ac6a-172075ccda76', '08:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('6eaaa8c1-6565-44bd-bd89-2bbd267ab295', '36cb5f4a-fd5e-4fc7-ac6a-172075ccda76', '08:00:00', '2026-03-14 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('ff1b025c-f0a0-44ac-8b1f-225e26439d52', '90e25a15-9daf-4e12-aced-cdda06c4cff0', '08:00:00', '2026-03-10 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('82552ab8-d6e8-47d2-87ae-d28854f618ff', '90e25a15-9daf-4e12-aced-cdda06c4cff0', '08:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('df14e048-1bb0-4c52-8326-a3fe2b7fffbc', '90e25a15-9daf-4e12-aced-cdda06c4cff0', '08:00:00', '2026-03-12 08:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('91ce2068-20e0-46c7-a3ba-40542a0e030e', '90e25a15-9daf-4e12-aced-cdda06c4cff0', '08:00:00', '2026-03-13 08:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('9faa6cad-4d8f-4982-b94a-c553fa0ebd0e', '90e25a15-9daf-4e12-aced-cdda06c4cff0', '08:00:00', '2026-03-14 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('5d671477-335c-4e08-9b33-08f9fb13887e', '38b62360-6844-4129-9bcd-93563c0225d2', '08:00:00', '2026-01-05 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('caeaca5e-41dc-4390-bffa-104f73c84569', '38b62360-6844-4129-9bcd-93563c0225d2', '20:00:00', '2026-01-10 20:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('cdd66392-3744-4dc3-9889-250b831f7154', '38b62360-6844-4129-9bcd-93563c0225d2', '08:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('8ee37930-5d4c-45b1-9c6c-9f0c3e8d4166', '38b62360-6844-4129-9bcd-93563c0225d2', '20:00:00', '2026-01-22 20:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('2133cd83-8554-4893-bd9b-e99c63fc74ba', '38b62360-6844-4129-9bcd-93563c0225d2', '08:00:00', '2026-01-31 08:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('7a80cb8f-5be2-4c88-9b0f-61d974008819', '262ef538-e0e5-4536-a24a-c01306a1f7c9', '09:00:00', '2026-03-10 09:05:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('3fb4342e-816d-47bb-8ca1-0cf9b0b5a7e7', '262ef538-e0e5-4536-a24a-c01306a1f7c9', '09:00:00', '2026-03-11 09:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('76803ef5-575e-445b-a865-9a7f75b29e45', '262ef538-e0e5-4536-a24a-c01306a1f7c9', '09:00:00', NULL, 'missed', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('9d49f636-cda2-45e9-80b1-5a2fe7015ef1', '262ef538-e0e5-4536-a24a-c01306a1f7c9', '09:00:00', '2026-03-13 09:10:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f'),
	('cce4406c-48a1-46d3-9e8b-6af3c1846583', '262ef538-e0e5-4536-a24a-c01306a1f7c9', '09:00:00', '2026-03-14 09:00:00', 'taken', '8daf9445-940d-48dc-b946-9ad9efdd171f');

INSERT INTO public.medication_schedules VALUES
	('40792db6-d6a5-4e54-b255-0119ae3523ac', '7744d33e-1d05-4326-b44f-e76df430b08b', '{08:00:00,14:00:00,20:00:00}', '{monday,wednesday,friday}', 1),
	('1d7a2e16-58ba-45b9-b276-266c938bd680', '3858d22a-52e5-444c-ad3a-c3b089bf1dce', '{09:00:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1),
	('48b516ea-0330-4efa-acc5-70863ba2379a', '16d3d420-3cea-4c76-9f64-aa010f8658a2', '{08:00:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1),
	('4664df18-02c3-406c-a46c-cfb4574a4408', '85236c48-8f0f-4593-834f-bad23e3ab514', '{08:00:00,20:00:00}', '{monday,wednesday,friday}', 1),
	('faaa652f-f942-411a-9e8c-bb0317577100', '94b912b3-34b6-419a-8e5a-5d3cd3c2e340', '{07:00:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1),
	('86cbf5da-7498-450b-8e72-d456b585914d', 'cd3fe22c-27b0-4c27-912a-632cc49098bc', '{07:30:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1),
	('f7cf05d3-4aca-4d67-b9b4-f09a6da02064', 'd9f04e7f-49ef-45f6-962b-ca9b1de1553a', '{08:00:00,18:00:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1),
	('5972ea67-d344-481c-b105-476f40a825c5', '81f4f01f-ee52-433d-9f70-9eb4c5c719f8', '{09:00:00}', '{monday,tuesday,wednesday,thursday,friday}', 1),
	('cbfdfbb4-e070-4efb-b652-8194f77fff47', '36cb5f4a-fd5e-4fc7-ac6a-172075ccda76', '{08:00:00,20:00:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1),
	('10d6e0df-790d-4be2-bc43-6792d27916ed', '90e25a15-9daf-4e12-aced-cdda06c4cff0', '{08:00:00,14:00:00,20:00:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1),
	('fa032890-0da3-4727-a6ee-91738ff3ea32', '38b62360-6844-4129-9bcd-93563c0225d2', '{08:00:00,20:00:00}', '{monday,wednesday,friday}', 1),
	('4cdee721-ca32-4d49-af34-deef7aad8c22', '262ef538-e0e5-4536-a24a-c01306a1f7c9', '{09:00:00}', '{monday,tuesday,wednesday,thursday,friday,saturday,sunday}', 1);

INSERT INTO public.medications VALUES
	('b1c75884-aa8e-4e99-a269-e0e3c49afefb', '{Advil,Ibuprofen}', '530646', '200 mg', 'tablet', 'Take 1 tablet every 6-8 hours with food as needed for pain or fever.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('b0ef5e45-9165-4c69-90a5-78b45691771b', '{Tylenol,Acetaminophen}', '483920', '500 mg', 'tablet', 'Take 1 tablet every 4-6 hours as needed for pain or fever.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('718aa7f1-6c63-48e8-b35d-c3a8e8875797', '{Lipitor,Atorvastatin}', '917364', '20 mg', 'tablet', 'Take once daily to help lower cholesterol and reduce cardiovascular risk.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('2201b528-dc58-41ad-84e0-adac2d9e47fd', '{Zoloft,Sertraline}', '650281', '50 mg', 'tablet', 'Take once daily at the same time each day for treatment of depression or anxiety.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('500228dc-fb08-4c74-8835-d16d61163287', '{Amoxil,Amoxicillin}', '274915', '500 mg', 'capsule', 'Take every 8-12 hours as prescribed and finish the entire course of antibiotics.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('1a592997-9614-4586-b0c0-6c73431a8871', '{Glucophage,Metformin}', '839102', '500 mg', 'tablet', 'Take with meals to help control blood sugar in patients with type 2 diabetes.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('bbfdff04-871d-4a3b-8524-6c2875174d05', '{Synthroid,Levothyroxine}', '561738', '75 mg', 'tablet', 'Take once daily on an empty stomach 30-60 minutes before breakfast for thyroid hormone replacement.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('58fc59bd-7d95-470d-a756-0c3786fc835c', '{Prilosec,Omeprazole}', '702459', '20 mg', 'capsule', 'Take once daily before a meal to reduce stomach acid and treat reflux.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('d8a0f8a1-80d3-4ffa-aa0e-d5cccc44e0e0', '{Norvasc,Amlodipine}', '318640', '5 mg', 'tablet', 'Take once daily to help control high blood pressure.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098'),
	('a26e53b3-8663-412b-84a7-64f41cc31528', '{Ventolin,Albuterol}', '945207', '90 mg', 'inhaler', 'Inhale 1-2 puffs every 4-6 hours as needed for relief of bronchospasm or shortness of breath.', '8daf9445-940d-48dc-b946-9ad9efdd171f', '2026-04-01 20:52:50.867098');

INSERT INTO public.users VALUES
	('8daf9445-940d-48dc-b946-9ad9efdd171f', 'Avery', 'avery@example.com', '$2b$12$A9VEDs6rpamSOYD/GnbN.OrYri7uHpH2/iEvbLQFxnTP20XyNmgku', 'caregiver', '2026-04-01 20:52:50.856551', '2026-04-01 20:52:50.856551'),
	('0432ab9c-eedc-421f-8903-dc4f70b513a3', 'Malcolm', 'malcolm@example.com', '$2b$12$A9VEDs6rpamSOYD/GnbN.OrYri7uHpH2/iEvbLQFxnTP20XyNmgku', 'family_member', '2026-04-01 20:52:50.856551', '2026-04-01 20:52:50.856551'),
	('b83f2a7f-855c-4c75-863d-9346e6eb90ea', 'Jade', 'jade@example.com', '$2b$12$A9VEDs6rpamSOYD/GnbN.OrYri7uHpH2/iEvbLQFxnTP20XyNmgku', 'family_member', '2026-04-01 20:52:50.856551', '2026-04-01 20:52:50.856551'),
	('652874de-4077-4ed2-8318-ceb4071ee25b', 'Rowan', 'rowan@example.com', '$2b$12$A9VEDs6rpamSOYD/GnbN.OrYri7uHpH2/iEvbLQFxnTP20XyNmgku', 'family_member', '2026-04-01 20:52:50.856551', '2026-04-01 20:52:50.856551'),
	('865b91ae-da7f-413d-af4c-d281183280ac', 'Victor', 'victor@example.com', '$2b$12$A9VEDs6rpamSOYD/GnbN.OrYri7uHpH2/iEvbLQFxnTP20XyNmgku', 'family_member', '2026-04-01 20:52:50.856551', '2026-04-01 20:52:50.856551');

SET session_replication_role = DEFAULT;