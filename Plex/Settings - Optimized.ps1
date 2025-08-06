<# Notes
2025-08-06 - Optimized server settings for Plex

### Settings:
Scan my library automatically	                                    ✅ Enabled
Run a partial scan when changes are detected	                    ✅ Enabled
Include music libraries in automatic updates	                    ❌ Disabled
Scan my library periodically	                                    ❌ Disabled
Library scan interval	                                            Daily
Empty trash automatically after every scan	                        ✅ Enabled
Allow media deletion	                                            ✅ Enabled
Weeks to consider for Continue Watching	                            16
Max Continue Watching items	                                        40
Include season premieres in Continue Watching	                    ✅ Enabled
Video played threshold	                                            90%
Video play completion behaviour	                                    Earliest between threshold percent and first credits marker
Enable smart shuffling on artists/playlists	                        ✅ Enabled
Group albums by type	                                            Enabled
Enable iTunes plugin	                                            ❌ Disabled
iTunes library XML path	                                            (Blank)
Run scanner tasks at a lower priority	                            ❌ Disabled
Marker source	                                                    Both, try online first
Generate video preview thumbnails	                                Never
Generate intro video markers	                                    As a scheduled task
Generate credits video markers	                                    As a scheduled task
Generate ad video markers	                                        Never
Generate voice activity data	                                    Never
Generate chapter thumbnails	                                        Never
Analyze audio tracks for loudness	                                Never
Analyze audio tracks for sonic features	                            As a scheduled task
Location visibility	                                                Admin only
Database cache size (MB)	                                        200

### Cleanup:
## "Generate video preview thumbnails"
# Windows
Set-Location "C:\Users\$env:username\AppData\Local\Plex Media Server\Media\localhost" | Remove-Item * -Include *.bif -Force
# MAC
rm -rf ~/Library/Application\ Support/Plex\ Media\ Server/Media/localhost/*.bif
# Synology
rm -rf "/volume1/Plex/Library/Application Support/Plex Media Server/Media/localhost/"*.bif

## Phototranscoder
# Windows
Remove-Item -Path "$env:LOCALAPPDATA\Plex Media Server\Cache\PhotoTranscoder\*" -Recurse -Force
# MAC
rm -rf /Users/*USERNAME*/Library/Caches/PlexMediaServer/PhotoTranscoder/*
# Synology
rm -rf "/volume1/Plex/Library/Application Support/Plex Media Server/Cache/PhotoTranscoder/"*
#>