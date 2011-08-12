require 'spec_helper'

describe RedisReader do
  describe 'redis' do
    it 'should return a connection to redis' do
      RedisReader.redis.should be_kind_of Redis
    end
  end

  describe 'command' do
    describe 'methods to retrive values' do
      it 'defines hgetall for hash' do
        RedisReader.command('')[:hash].first.should == :hgetall
      end

      it 'defines lrange for list' do
        RedisReader.command('')[:list].first.should == :lrange
      end

      it 'defines smembers for set' do
        RedisReader.command('')[:set].first.should == :smembers
      end

      it 'defines zrange for sorted set' do
        RedisReader.command('')[:zset].first.should == :zrange
      end

      it 'defines get for string' do
        RedisReader.command('')[:string].first.should == :get
      end
    end
  end

  describe 'get' do
    context 'hash' do
      it 'calls hgetall' do
        RedisReader.redis.hset('foo', 'bar', 'baz')
        result = RedisReader.get('foo')
        result[:key].should == 'foo'
        result[:type].should == :hash
        result[:value].should == {'bar' => 'baz'}
      end
    end

    context 'list' do
      it 'calls lrange' do
        RedisReader.redis.lpush('foo', 'bar')
        result = RedisReader.get('foo')
        result[:key].should == 'foo'
        result[:type].should == :list
        result[:value].should == ['bar']
      end
    end

    context 'set' do
      it 'calls smembers' do
        RedisReader.redis.sadd('foo', 'bar')
        result = RedisReader.get('foo')
        result[:key].should == 'foo'
        result[:type].should == :set
        result[:value].should == ['bar']
      end
    end

    context 'zset' do
      it 'calls zrange' do
        RedisReader.redis.zadd('foo', 15, 'bar')
        result = RedisReader.get('foo')
        result[:key].should == 'foo'
        result[:type].should == :zset
        value = result[:value].first
        value[:value].should == 'bar'
        value[:score].should == '15'
        value[:rank].should == 0
      end
    end

    context 'string' do
      it 'calls get' do
        RedisReader.redis.set('foo', 'bar')
        result = RedisReader.get('foo')
        result[:key].should == 'foo'
        result[:type].should == :string
        result[:value].should == 'bar'
      end
    end
  end
end
