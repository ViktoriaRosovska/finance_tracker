insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true);

update storage.buckets
set allowed_mime_types = array[
  'image/jpeg',
  'image/jpg',
  'image/webp',
  'image/png',
  'image/gif'
], 
file_size_limit = 5242880
where id = 'avatars';


