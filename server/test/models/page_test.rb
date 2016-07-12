require 'test_helper'

class PageTest < BaseTestCase
  sub_test_case 'validations' do
    sub_test_case 'format' do
      test 'path' do
        assert { build(:page, path: '/').valid? }
        assert { build(:page, path: '/a').valid? }
        assert { build(:page, path: '/あ').valid? }
        assert { build(:page, path: '/a.a').valid? }
        assert { build(:page, path: '/a.txt').valid? }

        assert { build(:page, path: '').invalid? }
        assert { build(:page, path: 'a').invalid? }
        assert { build(:page, path: '//').invalid? }
        assert { build(:page, path: '//a').invalid? }
        assert { build(:page, path: '/a/').invalid? }
        assert { build(:page, path: '/a//').invalid? }
        assert { build(:page, path: '/a..').invalid? }
        assert { build(:page, path: '/..b').invalid? }
        assert { build(:page, path: '/a..b').invalid? }
        assert { build(:page, path: '/a.md').invalid? }
        assert { build(:page, path: '/*').invalid? }
        assert { build(:page, path: '/.').invalid? }
        assert { build(:page, path: '/./.').invalid? }
        assert { build(:page, path: '/a.').invalid? }
        assert { build(:page, path: '/.a').invalid? }
      end
    end
  end
end
