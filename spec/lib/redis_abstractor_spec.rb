require 'spec_helper'

describe RedisAbstractor do
  describe '.redis' do
    it 'should return a connection to redis' do
      RedisAbstractor.redis.should be_kind_of Redis
    end
  end

  describe '.keys' do
    context 'no keys' do
      it 'returns an empty array' do
        RedisAbstractor.keys.should == []
      end
    end

    context 'keys' do
      it 'returns the keys in redis' do
        RedisAbstractor.redis.set('foo', 'foo')
        RedisAbstractor.redis.set('bar', 'bar')
        keys = RedisAbstractor.keys
        keys.size.should == 2
        keys.should include 'foo'
        keys.should include 'bar'
      end
    end
  end

  describe '.get' do
    before do
      RedisAbstractor.redis.set('str', 'bar')
      RedisAbstractor.redis.hset('hsh', 'foo', 'bar')
    end

    it 'returns the keys, types, and values' do
      result = RedisAbstractor.get(['str', 'hsh'])
      result.size.should == 2
      result.should include({'key' => 'str', 'type' => 'string', 'value' => 'bar'})
      result.should include({'key' => 'hsh', 'type' => 'hash', 'value' => {'foo' => 'bar'}})
    end
  end

  describe '.del' do
    it 'deletes the key' do
      RedisAbstractor.redis.set('foo', 'bar')
      RedisAbstractor.keys.size.should == 1
      RedisAbstractor.del('foo')
      RedisAbstractor.keys.size.should == 0
    end
  end
end
