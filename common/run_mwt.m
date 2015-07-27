% directory of all files from one recording day - as a string
% number_vid numgber of recordings that day - as a number
% example run_mwt('20150401',3)

% multiwellTracker(directorio,raizarchivos,directorio_destino,n_platos,solopartemanual)
function run_mwt(date,number_vid)

    cd('C:\Users\User\Documents\MATLAB\multiwelltracker')
    trial = 1;
    subfolder = ['trial' num2str(trial)];
    direct = ['D:\data\' date '\' subfolder];
    datosegm = multiwellTracker(direct,'video_',[],0,1);
    multiwellTracker(datosegm) %run for trial1
    
    for i = 2:number_vid
        
        load([direct '\segm\datosegm.mat']);
        trial = trial +1;
        subfolder = ['trial' num2str(trial)];
        direct = ['D:\data\' date '\' subfolder];
        
        datosegm.directorio = [direct '\segm\'];
        datosegm.directorio_videos = [direct '\'];
        
        obj = VideoReader([direct '\video_1.avi']);
        nframes_act=get(obj,'NumberOfFrames');
        
        datosegm = rmfield(datosegm,'frame2archivo');
        datosegm = rmfield(datosegm,'archivo2frame');
        
        datosegm.frame2archivo(1:nframes_act,1)=1;
        datosegm.frame2archivo(1:nframes_act,2)=1:nframes_act;
        datosegm.archivo2frame(1,1:nframes_act)=1:nframes_act;
        
        if isempty(dir([direct '\segm']))
        mkdir([direct '\segm'])
        end
    
        save([direct '\segm\datosegm.mat'],'datosegm')
        multiwellTracker(datosegm)
      
    end
    
    cd('C:\Users\User\Documents\MATLAB\traces')
end