module DataKitten

  # A file format for a distribution
  # 
  # For instance CSV, XML, etc.
  #
  class DistributionFormat
   
    #@!attribute extension
    #@return [Symbol] a symbol for the file extension. For instance, :csv.
    attr_reader :extension

    # Create a new DistributionFormat object with the relevant extension
    #
    # @param extension [String] the file extension for the format
    def initialize(extension, response)
      # Store extension as a lowercase symbol
      @extension = extension.to_s.downcase.to_sym
      # Store response for later use
      @response = response
      # Set up format lists
      @@formats ||= {
        csv:     { structured:  true, open:  true },
        xls:     { structured:  true, open: false },
        rdf:     { structured:  true, open:  true },
        xml:     { structured:  true, open:  true },
        wms:     { structured:  true, open:  true },
        ods:     { structured:  true, open:  true },
        rdfa:    { structured:  true, open:  true },
        kml:     { structured:  true, open:  true },
        rss:     { structured:  true, open:  true },
        json:    { structured:  true, open:  true },
        ical:    { structured:  true, open:  true },
        sparql:  { structured:  true, open:  true },
        kml:     { structured:  true, open:  true },
        georss:  { structured:  true, open:  true },
        shp:     { structured:  true, open:  true },
        html:    { structured: false, open:  true },
        doc:     { structured: false, open:  false },
        pdf:     { structured: false, open:  true },  
      }
    end

    # Is this a structured format?
    #
    # @return [Boolean] whether the format is machine-readable or not.
    def structured?
      @@formats[@extension][:structured] rescue nil
    end

    # Is this an open format?
    #
    # @return [Boolean] whether the format is open or not
    def open?
      @@formats[@extension][:open] rescue nil
    end
    
    # Whether the format of the file matches the extension given by the data
    #
    # @return [Boolean] whether the MIME type given in the HTTP response matches the data or not
    def matches?
      begin
        mimes = []
        MIME::Types.type_for(@extension.to_s).each { |i| mimes << i.content_type }
        !!(@response.headers[:content_type] =~ /#{mimes.join('|')}/) || false
    rescue
      nil
    end
    end

  end  

end
