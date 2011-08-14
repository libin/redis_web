require 'spec_helper'

describe RedisCommand do
  describe '.redis' do
    it 'returns a redis instance' do
      RedisCommand.redis.should be_kind_of Redis
    end
  end

  describe '.type' do
    context 'hash' do
      it 'returns hash' do
        RedisCommand.redis.hset('foo', 'bar', 'baz')
        RedisCommand.type('foo').should == 'hash'
      end
    end

    context 'list' do
      it 'returns list' do
        RedisCommand.redis.lpush('foo', 'bar')
        RedisCommand.type('foo').should == 'list'
      end
    end

    context 'set' do
      it 'returns set' do
        RedisCommand.redis.sadd('foo', 'bar')
        RedisCommand.type('foo').should == 'set'
      end
    end

    context 'zset' do
      it 'returns zset' do
        RedisCommand.redis.zadd('foo', 15, 'bar')
        RedisCommand.type('foo').should == 'zset'
      end
    end

    context 'string' do
      it 'returns string' do
        RedisCommand.redis.set('foo', 'bar')
        RedisCommand.type('foo').should == 'string'
      end
    end
  end

  describe '.hash' do
    it 'returns the values of the hash' do
      RedisCommand.redis.hset('foo', 'bar', 'baz')
      RedisCommand.hash('foo').should == {'bar' => 'baz'}
    end
  end

  describe '.list' do
    it 'returns the values of the list' do
      RedisCommand.redis.lpush('foo', 'bar')
      RedisCommand.list('foo').should == ['bar']
    end
  end

  describe '.set' do
    it 'returns the values of the set' do
      RedisCommand.redis.sadd('foo', 'bar')
      RedisCommand.set('foo').should == ['bar']
    end
  end

  describe '.zset' do
    it 'returns the values of the sorted set' do
      RedisCommand.redis.zadd('foo', 15, 'bar')
      RedisCommand.zset('foo').should == [{'value' => 'bar', 'score' => "15"}]
    end
  end

  describe '.string' do
    it 'returns the value of the string' do
      RedisCommand.redis.set('foo', 'bar')
      RedisCommand.string('foo').should == 'bar'
    end
  end

  describe '.get' do
    context 'hash' do
      it 'returns the value of the hash' do
        RedisCommand.redis.hset('foo', 'bar', 'baz')
        RedisCommand.get('hash', 'foo').should == {'bar' => 'baz'}
      end
    end

    context 'list' do
      it 'returns the value of the list' do
        RedisCommand.redis.lpush('foo', 'bar')
        RedisCommand.get('list', 'foo').should == ['bar']
      end
    end

    context 'set' do
      it 'returns the value of the set' do
        RedisCommand.redis.sadd('foo', 'bar')
        RedisCommand.get('set', 'foo').should == ['bar']
      end
    end

    context 'zset' do
      it 'returns the value of the sorted set' do
        RedisCommand.redis.zadd('foo', 15, 'bar')
        RedisCommand.get('zset', 'foo').should == [{'value' => 'bar', 'score' => "15"}]
      end
    end
  end
end
