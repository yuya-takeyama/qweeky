class Page < ApplicationRecord
  has_many :revisions

  validates :path, uniqueness: true

  PATH_PATTERN = %r{\A
    /
    (?:
      [^/\.](?:[^/]+[^/\.])?
      (?:/[^/\.](?:[^/]+[^/\.])?)*
    )?
  \z}x

  validate do
    errors.add(:path, 'Invalid path') if path.index('*')
    errors.add(:path, 'Invalid path') if path.index('..')
    errors.add(:path, 'Invalid path') if path.index('//')
    errors.add(:path, 'Invalid path') if path.end_with?('.md')
    errors.add(:path, 'Invalid path') unless path =~ PATH_PATTERN
  end
end
