{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    mpv
    mediainfo
    ffmpeg-full
    yt-dlp
  ];
  environment.shellInit = ''
    function ff_convert_segments_qsv() {
      input_file="$1";
      [ "$input_file" = "" ] && echo -n "source path: " && read -n input_file ;

      seg_time="$2";
      [ "$seg_time" = "" ] && echo -n "segments time: " && read -n seg_time ;

      prefix="$3";
      [ "$prefix" = "" ] && echo -n "prefix: " && read -n prefix ;
      
      ffmpeg -loglevel quiet -i "$input_file" -c:v h264_qsv -c:a aac -map 0 -segment_time $seg_time -f segment -reset_timestamps 1 "$(echo $prefix)%03d.mp4"
    }

    function ff_convert_qsv() {
      src_file="$1"; [ "$src_file" = "" ] && echo -n "src file: " && read -n src_file ;
      dst_file="$2"; [ "$dst_file" = "" ] && echo -n "dst file: " && read -n dst_file ;
      ffmpeg -loglevel info -i "$src_file" -c:v -c:v h264_qsv -c:a aac "$dst_file";
    }
  '';
  environment.shellAliases = { };
}
