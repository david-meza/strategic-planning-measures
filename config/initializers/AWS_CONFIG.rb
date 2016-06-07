AWS_CONFIG = {
 'access_key_id' => ENV["AWS_ACCESS_KEY_ID"],
 'secret_access_key' => ENV["AWS_SECRET_ACCESS_KEY"],
 'bucket' => ENV["S3_BUCKET_NAME"],
 'acl' => 'public-read',
 'key_start' => 'uploads/'
}