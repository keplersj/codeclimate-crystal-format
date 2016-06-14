require "../spec_helper"
require "json"

describe "CodeClimate Engine Spec" do
  describe "engine.json" do
    path = "#{Dir.current}#{File::SEPARATOR}engine.json"

    it "exists" do
      File.exists?(path).should be_true
    end

    json = JSON.parse(File.open(path))

    describe "Name" do
      it "exists" do
        json["name"].should be_truthy
      end
    end

    describe "Description" do
      it "exists" do
        json["description"].should be_truthy
      end

      it "is tweet sized" do
        (json["description"].to_s.size <= 140).should be_true
      end
    end

    describe "Maintainer" do
      it "exists" do
        json["maintainer"].should be_truthy
      end

      it "has name" do
        json["maintainer"]["name"].should be_truthy
      end
    end

    describe "Languages" do
      it "exists" do
        json["language"].should be_truthy
      end
    end

    describe "Version" do
      it "exists" do
        json["version"].should be_truthy
      end
    end
  end
end
