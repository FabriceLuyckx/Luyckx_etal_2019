function [OUTEEG, com] = pop_visualinspecttrials(INEEG)

    g1 = [0.5 0.5 ];
    g2 = [0.35 0.15 0.35 0.15];
    s1 = [1];
    geometry = { g1 s1 g2 s1 g1 s1 g1 s1 g1 s1 g1 g1 g1 s1 s1 s1 s1 s1 s1 s1 s1 s1 };
    uilist = { ...
          { 'Style', 'text', 'string', 'Channels to Average Across'} ...
          { 'Style', 'edit', 'string', 'CZ, CPZ, PZ' 'tag' 'Channels'  } ...
          ...
          { } ...
          ...
          { 'Style', 'text', 'string', 'Rows to Display'} ...
          { 'Style', 'edit', 'string', '3' 'tag' 'Rows'  } ...
          { 'Style', 'text', 'string', 'Columns to Display'} ...
          { 'Style', 'edit', 'string', '4' 'tag' 'Columns'  } ...
          ...
          { } ...
          ...
          { 'Style', 'text', 'string', 'Display ERP Average'} ...
          { 'Style', 'popupmenu', 'string', 'True | False' 'tag' 'Average' } ...
          ...
          { } ...
          ...
          { 'Style', 'text', 'string', 'Plot Polarity'  } ...
          { 'Style', 'popupmenu', 'string', 'Positive Down | Positive Up' 'tag' 'Polarity' } ...
          ...
          { } ...
          ...
          { 'Style', 'text', 'string', 'Smooth Data'  } ...
          { 'Style', 'popupmenu', 'string', 'True | False' 'tag' 'Smooth' } ...
          ...
          { } ...
          ...
          { 'Style', 'text', 'string', 'Plot Location and Size'  } ...
          { 'Style', 'edit', 'string', '[200,200,1600,800]' 'tag' 'guiSize'  } ...
          ...
          { } ...
          { 'Style', 'text', 'string', 'pixels: (right, up, wide, tall)'  } ...
          ...
          { 'Style', 'text', 'string', 'Font Size' } ...
          { 'Style', 'edit', 'string', '8' 'tag' 'guiFontSize' } ...
          ...
          { } ...
          ...
          { 'Style', 'text', 'string', 'To reject a trial, click on the axis of the trial.' } ...
          ...
          { 'Style', 'text', 'string', 'Rejected trials will have a red background.' } ...
          ...
          { 'Style', 'text', 'string', 'To accept a trial, click the axis of the trial again.' } ...
          ...
          { 'Style', 'text', 'string', 'Arrow Left and Right can be used to scroll through the data.' } ...
          ...
          { 'Style', 'text', 'string', 'Arrow Up and Down scale the amplitude.' } ...
          ...
          { 'Style', 'text', 'string', 'Holding shift while using the up and down arrow will linearly shift' } ...
          ...
          { 'Style', 'text', 'string', 'the axis up or down.' } ...
          ...
          { } ...
          ...
      };
 
      [ tmp1 tmp2 strhalt structout ] = inputgui( geometry, uilist, 'pophelp(''pop_visualinspecttrials'');', 'Visually Inspect EEG trials -- pop_visualinspecttrials');
      if ~isempty(structout)
          structout.Channels = strsplit(structout.Channels,',');
          structout.Channels2 = sprintf('''%s''', strtrim(structout.Channels{1}));
          if (size(structout.Channels,2) > 1)
              for rC = 2:size(structout.Channels,2)
                  temp = sprintf(', ''%s''', strtrim(structout.Channels{rC}));
                  structout.Channels2 = [structout.Channels2, temp];
              end
          end
          structout.Rows = str2num(structout.Rows);
          structout.Columns = str2num(structout.Columns);
          structout.guiFontSize = str2num(structout.guiFontSize);
          structout.guiSize = str2num(structout.guiSize);
          if (structout.Polarity == 1)
              structout.Polarity = 'Positive Down';
          else
              structout.Polarity = 'Positive Up';
          end
          if (structout.Average == 1)
              structout.Average = 'True';
          else
              structout.Average = 'False';
          end
          if (structout.Smooth == 1)
              structout.Smooth = 'True';
          else
              structout.Smooth = 'False';
          end
          com = sprintf('\nRunning:\n\t%s = visualinspecttrials(%s, ''Channels'', {%s}, ''Rows'', %d, ''Columns'', %d, ''Polarity'', ''%s'', ''Average'', ''%s'', ''Smooth'', ''%s'', ''guiSize'', %s, ''guiFontSize'', %d);\n', inputname(1), inputname(1),  structout.Channels2, structout.Rows, structout.Columns, structout.Polarity, structout.Average, structout.Smooth, mat2str(structout.guiSize), structout.guiFontSize);
          disp(com)
          OUTEEG = visualinspecttrials(INEEG, 'Channels', structout.Channels, 'Rows',  structout.Rows, 'Columns',  structout.Columns, 'Polarity', structout.Polarity, 'Average', structout.Average, 'Smooth', structout.Smooth,'guiSize', structout.guiSize, 'guiFontSize', structout.guiFontSize);
          disp('Updating EEG.reject.rejmanual...')
      else
          OUTEEG = INEEG;
          com = '';
      end

end