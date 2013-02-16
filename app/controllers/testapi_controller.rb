class TestapiController < ApplicationController
  def unit_testi
    system('./run_unit_test.sh')
    
    File.open("./unit_test_result.txt").each_line do |line|
      match = /(\d+) examples, (\d+) failures/.match(line)
      if match
        out = {:example => match[1], :failures => match[2]}
      end
    end
    print "************************"
    print out

    respond_to do |format|
      format.json { render json: out }
    end
  end

  def reset_fixture
    respond_to do |format| 
      Users.delete_all()
      format.json {render json: { errCode: 1 }}
    end
  end
end
