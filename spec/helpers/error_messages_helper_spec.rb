require "rails_helper"

describe ErrorMessagesHelper do
  describe "#error_messages_for" do
    it "returns nil when no messages" do
      expect(helper.error_messages_for(nil)).to be_nil
    end
    it "returns messages when messages" do
      client = Client.create
      expect(helper.error_messages_for(client)).to include "Invalid Fields"
    end
  end
  describe ErrorMessagesHelper::FormBuilderAdditions do
    describe "#error_messages" do
      it "calls ErrorMessagesHelper#error_messages_for" do
        class Foo
          include ErrorMessagesHelper::FormBuilderAdditions

          def initialize(template)
            @template = template
          end
        end
        expect(helper).to receive(:error_messages_for).once
        Foo.new(helper).error_messages
      end
    end
  end
  it "is included in FormBuilder" do
    expect(ActionView::Helpers::FormBuilder.included_modules).to include ErrorMessagesHelper::FormBuilderAdditions
  end
end
