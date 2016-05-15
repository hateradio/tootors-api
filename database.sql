-- (Re)creates the Tootors tables

drop sequence if exists tootors_id_seq cascade;

drop table if exists tootors cascade;

create table tootors (
  id serial primary key,
  is_tootor boolean,
  username varchar(255),
  seo_name varchar(255),
  email varchar(255),
  password text,
  name varchar(255),
  phone varchar(255),
  street varchar(255),
  city varchar(255),
  state char(2),
  zip char(5),
  focus text,
  description text,
  created_at timestamp,
  updated_at timestamp,
  visited_at timestamp
);

insert into tootors values (nextval('tootors_id_seq'), false, 'admin',
  'admin', 'email@calstate.edu', 'password1', 'Tootor Admin', '(310) 555-9801',
  '5151 State University Drive', 'Los Angeles', 'CA', '90032',
  'Computer Science, Math', 'I am an administrator!',
  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- CREATE OR REPLACE FUNCTION update_timestamp() RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS
-- $$
-- BEGIN
--     NEW.updated_at = CURRENT_TIMESTAMP;
--     RETURN NEW;
-- END;
-- $$;
--
-- CREATE TRIGGER on_update_set_timestamp
--   BEFORE UPDATE
--   ON tootors
--   FOR EACH ROW
--   EXECUTE PROCEDURE update_timestamp();

select setval('tootors_id_seq', (select max(id) from tootors));
