class MailMergeTokens

  attr_accessor :output_file, :number_to_write

  def initialize
    self.number_to_write   = 25
    self.output_file       = "/tmp/student_tokens.txt"
  end

  def run
    out = File.new(output_file, 'w')
    number_to_write.times do
      out.puts ApiToken.create.generated_token
    end
    out.close
  end

end