module BucketListHelper
  
 require 'aws-sdk' 
  @@client =""
  BUCKET_NAME = 'your bucket name'
  def bucket_list

     connect
     @@client.list_buckets.buckets.map(&:name)
  end

  # def self.get_files_list
  #   connect
  #
  #   files = Array.new
  #   bucket = Bucket.find(BUCKET_NAME)
  #   bucket.objects.each do |obj|
  #     files.push(obj.key) if obj.key.index('.')
  #     # zipの場合は、if File.extname(obj.key) == '.zip'
  #   end
  #
  #   return files
  # end
  #
  # def self.get_file(file_path)
  #   connect
  #   downloaded = 'download/' + File.basename(file_path)
  #   File.open(downloaded, 'wb') do |file|
  #     S3Object.stream(file_path, BUCKET_NAME) do |chunk|
  #       file.write chunk
  #     end
  #   end
  #   return downloaded
  # end

  private
  def connect

    @@client = Aws::S3::Client.new(
      :region => ENV['AWS_REGION'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'] ,
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']  ,
    )
    # Base.establish_connection!(
    #     :access_key_id => 'your access_key_id',
    #     :secret_access_key => 'your secret_access_key'
    # )
    # DEFAULT_HOST.replace('s3-ap-northeast-1.amazonaws.com')
  end

end
