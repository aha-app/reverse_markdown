require 'spec_helper'

describe ReverseMarkdown::Converters::Del do
  let(:converter) do
    ReverseMarkdown.new(github_flavored: github_flavored)
  end

  context 'with github_flavored = true' do
    let(:github_flavored) { true }

    it 'converts the input as expected' do
      input = '<del>deldeldel</del>'
      expect(converter.convert(input)).to eq '~~deldeldel~~'
    end

    it 'preserves enclosing bold and italic formatting' do
      input = '<strong><del>bold strike</del></strong> <em><del>italic strike</del></em>'
      expect(converter.convert(input).strip).to eq '**~~bold strike~~** _~~italic strike~~_'
    end

    it 'preserves whitespace around strikethrough content' do
      expect(converter.convert('before <del>removed</del> after').strip).to eq 'before ~~removed~~ after'
      expect(converter.convert('before<del>removed</del>after').strip).to eq 'before~~removed~~after'
    end

    it 'skips empty tags' do
      input = '<del></del>'
      expect(converter.convert(input)).to eq ''
    end
  end

  context 'with github_flavored = false' do
    let(:github_flavored) { false }

    it 'does not convert anything' do
      input = '<del>deldeldel</del>'
      expect(converter.convert(input)).to eq 'deldeldel'
    end
  end
end
