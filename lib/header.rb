class Header
 
    attr_reader :name_idx, :region_idx, :metropolis_idx, :province_idx, :plate_idx, :cf_idx

    def initialize headers
      @headers = headers
    end

    def istat_index

      @name_idx = @headers.index('Denominazione in italiano')
      @region_idx = @headers.index('Denominazione regione')
      @metropolis_idx = @headers.index('Denominazione Città metropolitana')
      @province_idx = @headers.index('Denominazione provincia')
      @plate_idx = @headers.index('Sigla automobilistica')
      @cf_idx = @headers.index('Codice Catastale del comune')
    end

end