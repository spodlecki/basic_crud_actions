RSpec.shared_examples 'a Respondable' do

  describe '.respond' do
    subject { described_class.new(double) }
    after { subject.respond }
    it 'invokes flash' do
      allow(subject).to receive(:redirect)
      expect(subject).to receive(:flash)
    end

    it 'invokes redirect' do
      allow(subject).to receive(:flash)
      expect(subject).to receive(:redirect)
    end
  end
end
