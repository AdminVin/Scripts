# Source: https://pleasework.robbievance.net/howto-force-really-wsus-clients-to-check-in-on-demand/
$updateSession = new-object -com "Microsoft.Update.Session"; $updates=$updateSession.CreateupdateSearcher().Search($criteria).Updates
wuauclt /reportnow