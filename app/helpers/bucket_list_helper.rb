module BucketListHelper

 require 'aws-sdk'
  @@client =""
  BUCKET_NAME = 'filmarks-env-list'

  def bucket_list

     connect
     @@client.list_buckets.buckets.map(&:name)
  end

  def file_list
    #@@client.list_objects(:bucket => 'filmarks-env-list').contents.each do |object|
    #    puts object.key
    #end

    resp = @@client.list_objects(bucket: BUCKET_NAME)
    resp.contents.map(&:key)

  end

  def file_download

    File.open("/tmp/kaka22", "w") do |file|   @@client.get_object(bucket: BUCKET_NAME, key: "envrc_unicorn_staging") do |chunk|     file.write chunk   end end


  end

  def file_upload

    file = File.open('/tmp/kaka')
    #file = File.open('/tmp/keke/haha')
    #file_name = File.basename('/tmp/keke2')
    file_name = File.basename('koko')

    @@client.put_object(
        bucket: BUCKET_NAME,
          body: file,
            key: file_name
    )
  end

  def get_export2
      p "h2"
  end

  def get_export
      #p "h2"

    #@@kk ={}
    @@kk = {"Lemon" => 100, "Orange" => 150}
    begin
      File.foreach("/tmp/kaka22") do | line |
        #puts line
        #' ' ""を全部削除してから？
      #puts "h2"

     ##＃@@kk =env_convert_hash(line) if line =~ /export /
     @kkk =(env_convert_hash(line)) if line =~ /export /
      #@@kk.store("keke",11)
      puts @kkk.class
      puts @@kk.class
      #puts @kkk


      @@kk.merge!(@kkk)
      #puts @@kk
      #puts hh.class
      #puts @env_list
      end
    rescue SystemCallError => e
       puts %Q(class=[#{e.class}] message=[#{e.message}])
    end
puts "hihihi"
puts @@kk
puts @@kk.class
     return @@kk

         #reture @@hh
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

  def env_convert_hash(str)
    #str.scan(/(\w+):\s+(\d+)/).map{|k, v| [k.to_sym, v.to_i] }.to_h
     str.scan(/(\w+)=["']?(.\w*)["']?/).map{|k,v| [k.to_sym, v.to_sym]}.to_h

    #puts str
  end

end
