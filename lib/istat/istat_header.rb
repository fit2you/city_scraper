class IstatHeader
 
  class << self
    
    def hash headers
      {
      name_idx: headers.index('Denominazione in italiano'),
      region_idx: headers.index('Denominazione Regione'),
      # metropolis_idx: headers.index("Denominazione dell'Unità territoriale sovracomunale (valida a fini statistici)"),
      province_idx: headers.index("Denominazione dell'Unità territoriale sovracomunale (valida a fini statistici)"),
      plate_idx: headers.index('Sigla automobilistica'),
      cf_idx: headers.index('Codice Catastale del comune')
      }
    end
  end

end