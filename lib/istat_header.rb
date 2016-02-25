class IstatHeader
 
  class << self
    
    def hash headers
      {
      name_idx: headers.index('Denominazione in italiano'),
      region_idx: headers.index('Denominazione regione'),
      metropolis_idx: headers.index('Denominazione Città metropolitana'),
      province_idx: headers.index('Denominazione provincia'),
      plate_idx: headers.index('Sigla automobilistica'),
      cf_idx: headers.index('Codice Catastale del comune')
      }
    end
  end

end