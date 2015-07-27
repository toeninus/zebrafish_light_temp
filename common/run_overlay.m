% to run overlay_vid as batch

function run_overlay(date,number_vid)

        
    for t = 1:number_vid
        trial = num2str(t);
        trialname = ['trial' trial]
        directory = ['D:\data\' date '\' trialname];
        
        overlay_video(directory,trialname) 
               
    end
end