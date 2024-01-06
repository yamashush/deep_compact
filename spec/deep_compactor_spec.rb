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
      ["a", nil, [], ["aa", "bb", nil]] | ["a", [], %w[aa bb]]
      ["a", "b", [], %w[aa bb cc]]      | ref(:source)
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
      { a: "1", b: nil, c: {}, d: { aa: "11", bb: "22", cc: nil } }   | { a: "1", c: {}, d: { aa: "11", bb: "22" } }
      { a: "1", b: "2", c: {}, d: { aa: "11", bb: "22", cc: "33" } }  | ref(:source)
    end

    with_them do
      it { should eq compacted }
    end
  end
end
