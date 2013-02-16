class TestapiController < ApplicationController
  def unit_test
    system('./run_unit_test.sh')
    output = { totalTests: 0, nrFailed: 0, output: "" }
    fuck = ""
    
    File.open("./unit_test_result.txt", "r").each_line do |line|
      match = /(\d+) examples, (\d+) failures/.match(line)
      output[:output] << line
      if match
        output[:totalTests] = Integer(match[1])
        output[:nrFailed] = Integer(match[2])
      end
    end


    respond_to do |format|
      format.json { render json: output }
    end
  end

  def reset_fixture
    respond_to do |format| 
      Users.delete_all()
      format.json {render json: { errCode: 1 }}
    end
  end
end
