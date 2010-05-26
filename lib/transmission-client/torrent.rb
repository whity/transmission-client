module Transmission
    class Torrent
        #ATTRIBUTES = ['activityDate', 'addedDate', 'bandwidthPriority', 'comment', 'corruptEver', 'creator', 'dateCreated', 'desiredAvailable', 'doneDate', 'downloadDir', 'downloadedEver', 'downloadLimit', 'downloadLimited', 'error', 'errorString', 'eta', 'hashString', 'haveUnchecked', 'haveValid', 'honorsSessionLimits', 'id', 'isPrivate', 'leftUntilDone', 'manualAnnounceTime', 'maxConnectedPeers', 'name', 'peer-limit', 'peersConnected', 'peersGettingFromUs', 'peersKnown', 'peersSendingToUs', 'percentDone', 'pieces', 'pieceCount', 'pieceSize', 'rateDownload', 'rateUpload', 'recheckProgress', 'seedRatioLimit', 'seedRatioMode', 'sizeWhenDone', 'startDate', 'status', 'swarmSpeed', 'totalSize', 'torrentFile', 'uploadedEver', 'uploadLimit', 'uploadLimited', 'uploadRatio', 'webseedsSendingToUs']
        #ADV_ATTRIBUTES = ['files', 'fileStats', 'peers', 'peersFrom', 'priorities', 'trackers', 'trackerStats', 'wanted', 'webseeds']
        ATTRIBUTES = ['files', 'wanted', 'activityDate', 'addedDate', 'bandwidthPriority', 'comment', 'corruptEver', 'creator', 'dateCreated', 'desiredAvailable', 'doneDate', 'downloadDir', 'downloadedEver', 'downloadLimit', 'downloadLimited', 'error', 'errorString', 'eta', 'hashString', 'haveUnchecked', 'haveValid', 'honorsSessionLimits', 'id', 'isPrivate', 'leftUntilDone', 'manualAnnounceTime', 'maxConnectedPeers', 'name', 'peer-limit', 'peersConnected', 'peersGettingFromUs', 'peersKnown', 'peersSendingToUs', 'percentDone', 'pieces', 'pieceCount', 'pieceSize', 'rateDownload', 'rateUpload', 'recheckProgress', 'seedRatioLimit', 'seedRatioMode', 'sizeWhenDone', 'startDate', 'status', 'swarmSpeed', 'totalSize', 'torrentFile', 'uploadedEver', 'uploadLimit', 'uploadLimited', 'uploadRatio', 'webseedsSendingToUs']
        ADV_ATTRIBUTES = ['fileStats', 'peers', 'peersFrom', 'priorities', 'trackers', 'trackerStats', 'webseeds']
        SETABLE_ATTRIBUTES = ['bandwidthPriority', 'downloadLimit', 'downloadLimited', 'files-wanted', 'files-unwanted', 'honorsSessionLimits', 'ids', 'location', 'peer-limit', 'priority-high', 'priority-low', 'priority-normal', 'seedRatioLimit', 'seedRatioMode', 'uploadLimit', 'uploadLimited']
    
        def initialize(attributes)
            ###files attribute###
            attributes['files'] = self._files_attribute(attributes['files'],
                                                        attributes['wanted'])
            
            attributes.delete('wanted') #delete key from hash
            #####################
            
            @attributes = attributes
        end
    
        def start
            Connection.instance.send('torrent-start', {'ids' => @attributes['id']})
        end
        
        def stop
            Connection.instance.send('torrent-stop', {'ids' => @attributes['id']})
        end
    
        def verify
            Connection.instance.send('torrent-verify', {'ids' => @attributes['id']})
        end
        
        def reannounce
            Connection.instance.send('torrent-reannounce', {'ids' => @attributes['id']})
        end
        
        def remove(delete_data = false)
            Connection.instance.send('torrent-remove', {'ids' => @attributes['id'], 'delete-local-data' => delete_data })
        end
        
        def move(location, move = true)
            Connection.instance.send('torrent-set-location', {'ids' => @attributes['id'], 'location' => location, 'move' => move})
        end
        
        def method_missing(m, *args, &block)
            if ATTRIBUTES.include? m.to_s
                return @attributes[m.to_s]
            elsif ADV_ATTRIBUTES.include? m.to_s
                raise "Attribute not yet supported."
            elsif m[-1..-1] == '='
                if SETABLE_ATTRIBUTES.include? m[0..-2]
                    Connection.instance.send('torrent-set', {'ids' => [@attributes['id']], m[0..-2] => args.first})  
                else
                    raise "Invalid Attribute."
                end
            else
              raise "Invalid Attribute."
            end
        end
        
        protected
            
            def _files_attribute(files, wanted)
                #transform each array position in a torrentfile object
                tor_files = Array.new()
                files.each_with_index() do |value, index|
                    value['wanted'] = (wanted[index].to_i() == 1) ? true : false
                    tor_files.push(TorrentFile.new(value))
                end
                
                return tor_files
            end
        
    end # end class
    
    class TorrentFile
        def initialize(attributes)
            @attributes = attributes
        end
        
        def method_missing(m, *args, &block)
            if (!@attributes.has_key?(m.to_s())) #if hash key not available, raise exception
                raise(Exception, "Invalid attribute")
            end
            
            return @attributes[m.to_s()]
        end
    end #end class
end