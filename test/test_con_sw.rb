require 'aws-sdk'
client = Aws::S3::Client.new(
  :region => ENV['AWS_REGION'],
  :access_key_id => ENV['AWS_ACCESS_KEY_ID'] ,
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']  ,
)


#client.create_bucket(:bucket => 'filmarks-env-list')
puts client.list_buckets.buckets.map(&:name)




