# An extra method for hashes
module HashHelper
  def self.pop_hash_val(hash)
    key = hash.keys.first
    val = hash.delete(key)
    [key, val]
  end
end
