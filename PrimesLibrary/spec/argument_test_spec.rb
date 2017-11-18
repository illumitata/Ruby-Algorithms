require_relative '../lib/prime'

describe ArgumentTest do
  include ArgumentTest

  describe '#checkIfString(argument)' do
    it 'return error for a string or float' do
      expect { checkIfString('100') }.to raise_error(ArgumentError)
      expect { checkIfString('super dokładność') }.to raise_error(ArgumentError)
      expect { checkIfString(9999) }.not_to raise_error
      expect { checkIfString(10) }.not_to raise_error
      expect { checkIfString(-100) }.not_to raise_error
      expect { checkIfString(0.927) }.to raise_error(ArgumentError)
    end
  end

  describe '#checkIfGreater(argument)' do
    it 'return error for a string or float' do
      expect { checkIfGreater('100', 5) }.to raise_error(ArgumentError)
      expect { checkIfGreater('super precise!') }.to raise_error(ArgumentError)
      expect { checkIfGreater(9999, 10) }.not_to raise_error
      expect { checkIfGreater(10, 6) }.not_to raise_error
      expect { checkIfGreater(-100, -1000) }.not_to raise_error
      expect { checkIfGreater(0.927, 10) }.to raise_error(ArgumentError)
      expect { checkIfGreater(10, 0.9292) }.not_to raise_error
    end
  end

  describe '#checkIfMore(argument)' do
    it 'return error for an integer less than 2' do
      expect { checkIfMore(-100) }.to raise_error(ArgumentError)
      expect { checkIfMore(1) }.to raise_error(ArgumentError)
      expect { checkIfMore(2) }.to raise_error(ArgumentError)
      expect { checkIfMore(4) }.not_to raise_error
      expect { checkIfMore(100) }.not_to raise_error
    end
  end
end
