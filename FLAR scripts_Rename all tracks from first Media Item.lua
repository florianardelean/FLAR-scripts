-- @description - Renames ALL tracks according to the name of the first media item on each track.
-- @description - Media item names are retrieved from the source of the first active take on each item. 
-- @description - It will only consider the first media item on each track for renaming the track.
-- @description - ALL Tracks will be renamed!
-- @author Florian Ardelean
-- @version 1.0
-- @link https://www.florianardelean.com
-- @Released under GNU General Public License v2.0

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function main()
  local numTracks = reaper.CountTracks(0)
  
  for i = 0, numTracks - 1 do
    local track = reaper.GetTrack(0, i)
    local numItems = reaper.CountTrackMediaItems(track)
    
    if numItems > 0 then
      local item = reaper.GetTrackMediaItem(track, 0)
      local take = reaper.GetActiveTake(item)
      
      if take ~= nil then
        local _, itemName = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", false)
        
        -- Set track name to the first item name
        if itemName ~= nil and itemName ~= "" then
          reaper.GetSetMediaTrackInfo_String(track, "P_NAME", itemName, true)
        end
      end
    end
  end
  
  reaper.UpdateArrange()
end

reaper.Undo_BeginBlock()

main()

reaper.Undo_EndBlock("FLAR Scripts_Rename all tracks from first Media Item", -1)
