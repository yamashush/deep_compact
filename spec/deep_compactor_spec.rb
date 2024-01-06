# frozen_string_literal: true

RSpec.describe DeepCompactor do
  using described_class

  it "has a version number" do
    expect(DeepCompactor::VERSION).not_to be nil
  end

  describe "Array#deep_compact" do
    subject { source.deep_compact }

    using DeepCompactor
    using RSpec::Parameterized::TableSyntax

    where(:source, :compacted) do
      ["a", nil, [], ["aa", "bb", nil, []]] | ["a", [], ["aa", "bb", []]]
      ["a", "b", [], %w[aa bb cc dd]]       | ref(:source)
    end

    with_them do
      it { should eq compacted }
    end
  end

  describe "Array#deep_compact!" do
    subject { source.deep_compact! }

    using DeepCompactor
    using RSpec::Parameterized::TableSyntax

    where(:source, :compacted, :result) do
      ["a", nil, [], ["aa", "bb", nil, []]] | ["a", [], ["aa", "bb", []]] | ref(:compacted)
      ["a", "b", [], %w[aa bb cc dd]]       | ref(:source)                | nil
    end

    with_them do
      it "source be compacted" do
        subject
        expect(source).to eq compacted
      end
      it "should be result" do
        expect(subject).to eq result
      end
    end
  end

  describe "Array#deep_compact_blank" do
    subject { source.deep_compact_blank }

    using DeepCompactor
    using RSpec::Parameterized::TableSyntax

    where(:source, :compacted) do
      ["a", nil, [], ["aa", "bb", nil, []]] | ["a", %w[aa bb]]
      ["a", "b", "c", %w[aa bb cc dd]]      | ref(:source)
    end

    with_them do
      it { should eq compacted }
    end
  end

  describe "Hash#deep_compact" do
    subject { source.deep_compact }

    using DeepCompactor
    using RSpec::Parameterized::TableSyntax

    where(:source, :compacted) do
      { a: "1", b: nil, c: {}, d: { aa: "11", bb: "22", cc: nil, dd: {} } }   | { a: "1", c: {}, d: { aa: "11", bb: "22", dd: {} } }
      { a: "1", b: "2", c: {}, d: { aa: "11", bb: "22", cc: "33", dd: {} } }  | ref(:source)
    end

    with_them do
      it { should eq compacted }
    end
  end

  describe "Hash#deep_compact_blank" do
    subject { source.deep_compact_blank }

    using DeepCompactor
    using RSpec::Parameterized::TableSyntax

    where(:source, :compacted) do
      { a: "1", b: nil, c: {}, d: { aa: "11", bb: "22", cc: nil, dd: {} } }                         | { a: "1", d: { aa: "11", bb: "22" } }
      { a: "1", b: "2", c: { aa: "11" }, d: { aa: "11", bb: "22", cc: "33", dd: { aaa: "111" } } }  | ref(:source)
    end

    with_them do
      it { should eq compacted }
    end
  end
end
