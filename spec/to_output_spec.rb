require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "to_output" do
  describe Object do
    it "should wrap to_s" do
      o = Object.new
      value = mock("value")
      o.should_receive(:to_s).and_return(value)
      o.to_output.should == value
    end
  end

  describe "nil" do
    it "should be 'None' by default" do
      nil.to_output.should == 'None'
    end
    it "should be overridable with config" do
      value = mock("value")
      ToOutput.config(:nil, value)
      nil.to_output.should == value
    end
  end

  describe "true" do
    it "should be 'Yes' by default" do
      true.to_output.should == 'Yes'
    end
    it "should be overridable with config" do
      value = mock("value")
      ToOutput.config(:true, value)
      true.to_output.should == value
    end
  end

  describe "false" do
    it "should be 'No' by default" do
      false.to_output.should == 'No'
    end
    it "should be overridable with config" do
      value = mock("value")
      ToOutput.config(:false, value)
      false.to_output.should == value
    end
  end

  # Ruby date formatting sucks, TODO: replace with custom?
  describe Date do
    it "should use dd/mm/yyyy by default" do
      d = Date.civil(1999, 7, 21)
      d.to_output.should == "21/07/1999"
    end
    it "should have format overridable with config" do
      ToOutput.config(:date, "%d %B %y")
      d = Date.civil(2002, 7, 5)
      d.to_output.should == "05 July 02"
    end
  end
  describe DateTime do
    it "should use dd/mm/yyyy hh:mm by default" do
      d = DateTime.civil(1999, 7, 21, 15, 37)
      d.to_output.should == "21/07/1999 15:37"
    end
    it "should have format overridable with config" do
      ToOutput.config(:datetime, "%d %B %y %I:%M%p")
      d = DateTime.civil(2002, 7, 5, 17, 12)
      d.to_output.should == "05 July 02 05:12PM"
    end
  end

  describe Time do
    it "should use local time dd/mm/yyyy hh:mm by default" do
      t = Time.local(1999, 7, 21, 15, 37)
      t.to_output.should == "21/07/1999 15:37"
    end
    it "should have format overridable with config" do
      ToOutput.config(:datetime, "%d %B %y %I:%M%p")
      t = Time.local(2002, 7, 5, 17, 12)
      t.to_output.should == "05 July 02 05:12PM"
    end
  end

  describe Array do
    it "should join with ', ' by default" do
      a = [1, 2, 3]
      a.to_output.should == "1, 2, 3"
    end
    it "should to_output its members before joining" do
      a = (1..4).map do |i|
        v = mock("value")
        v.stub!(:to_output).and_return("value #{i}")
        v
      end
      a.to_output.should == "value 1, value 2, value 3, value 4"
    end
    it "should have glue overridable with config" do
      ToOutput.config(:array_glue, '-')
      ['a', 'b', 'c'].to_output == 'a-b-c'
    end
  end

end
