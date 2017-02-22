# encoding: utf-8

require 'rubygems'


module Uploads

  class Manager

    # file_format может быть двух видов :xls и :csv

    PARSERS = { xls: XLSParser, csv: CSVParser }

    def self.async_process_file(file, client)
      full_file_path = save_file(file)
      # Resque.enqueue(CreateUploadAndParseFileTask, full_file_path, client.id)
      # CreateUploadAndParseFileTask.perform(full_file_path, client.id)
      Uploads::Manager.process_file(full_file_path, client)
    end

    def self.save_file(file)
      file_name = (file.try(:original_filename) ? file.original_filename : file.filename)
      name =  "#{Digest::SHA1.hexdigest(Time.now.to_s)}_#{file_name}"
      full_file_path = "#{Rails.root}/#{File.join("public/data", name)}"
      if file.instance_of?(Tempfile)
        FileUtils.cp(file.local_path, full_file_path)
      else
        File.open(full_file_path, "wb") { |f| f.write(file.read) }
      end
      full_file_path

    end

    def self.process_file(full_file_path, client, file_format = :xls)
      return false unless PARSERS[file_format]
      PARSERS[file_format].new(full_file_path, client).parse
      # upload.make_processed!
      Dir.chdir(File.dirname( full_file_path ))
      File.delete full_file_path if File.exist? full_file_path
    end

  end

end