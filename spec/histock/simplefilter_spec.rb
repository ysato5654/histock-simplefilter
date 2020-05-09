RSpec.describe Histock::Simplefilter do
    it 'has a version number' do
        expect(Histock::Simplefilter::VERSION).not_to be nil
    end

    let :histock do
        Histock::Simplefilter.new
    end

    let :code do
        '2330'
    end

    describe '#monthly_revenue(code)' do
        subject do
            histock.monthly_revenue(code)
        end

        let :header do
            ["年度/月份", "單月營收", "去年同月營收", "單月月增率", "單月年增率", "累計營收", "去年累計營收", "累積年增率"]
        end

        describe 'first index' do
            it 'is correct' do
                expect(subject.first).to eq(header)
            end
        end

        describe 'other indexes' do
            it 'are correct' do
                subject.each do |e|
                    expect(e.length).to eq(header.length)
                end
            end
        end
    end

    describe '#dividend_policy(code)' do
        subject do
            histock.dividend_policy(code)
        end

        let :header do
            ["所屬年度", "發放年度", "除權日", "除息日", "除權息前股價", "股票股利", "現金股利", "EPS", "配息率", "現金殖利率", "扣抵稅率", "增資配股率", "增資認購價"]
        end

        describe 'first index' do
            it 'is correct' do
                expect(subject.first).to eq(header)
            end
        end

        describe 'other indexes' do
            it 'are correct' do
                subject.each do |e|
                    expect(e.length).to eq(header.length)
                end
            end
        end
    end
end
