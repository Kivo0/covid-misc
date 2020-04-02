%% Thomas Merkh, tmerkh@g.ucla.edu
%% This script loads in the Library_Matrix data which is constructed from Construct_Library_Matrix.py
%% Section 1 - Plots the relative frequency of select words on the same plot.  Relative frequency means the data for any word on a given day is normalized by the number of tweets available for the day
%% Then, Each row is normalized such that the row sum is 1.  When plotted, this emphasizes which days each word occured the most.  For example, if toilet = 0.7 on March 1st, then 70% of the instances of the word toilet occured on March 1st. 

%% Under construction, Section 2 will plot financial fall out terms, such as stock, stimulus, economy, etc.  

load('Word_Library_Matrix/Library_Matrix1.mat')
load('Word_Library_Matrix/Library_Matrix1col_count.mat')
load('Word_Library_Matrix/Library_Matrix1row_count.mat')

data = Library_Matrix1;
data_cols = Library_Matrix1col_count;  % Total Tweets per day
data_rows = Library_Matrix1row_count;  % Total Instances of each word = sum(data,2)
data_normalized_col = zeros(size(data));
data_normalized_row = zeros(size(data));

library = {'pandemic','covid19','coronavirus','china','wuhan','wuhanvirus','trump','stimulus','economy','health','hospital','hospitals','distancing','social','america','americas','europe','italy','spain','france','germany','chinavirus','racist','shelter','medical','epidemic','pence','stock','market','markets','fauci','conservatives','liberals','democrats','republicans','asian','asia','panic','fake','closure','schools','universities','university','symptoms','cough','lungs','dead','dying','die','recovered','restrictions','recession','ventilators','respiratory','masks','mask','gloves','ppe', 'protective','stayathome','trumpmadness','safehands','viewfrommywindow','mypandemicsurvivalplan','quarantineandchill','flu','usa','corona','students','cdc','canceled','cancelled','crisis','tests','test','god','sanitizer','research','toilet','epicenter','groceries','grocery','war','invisible'};

%%%%%%%%%%%%%%%%%%%
%%%% SECTION 1 %%%%
%%%%%%%%%%%%%%%%%%%
% plot(data') == all words over time, messy!
OGdata = data;

% Normalize each column by the number of tweets available for that day
for i = 1:size(data_cols,2) % 40
  if(data_cols(i) > 1000)  % Number of tweets available on a day
    data(:,i) = data(:,i)/double(data_cols(i));
  else
    data(:,i) = zeros(size(data,1),1);
  endif  
endfor
 
% This correctly normalizes the tweets so that the sum of each row is 1.  This 
% emphasizes relatively when a word was most relevant

index_list = [1,2,3,5,6,22,26,39,45,53,55,77,79];
for i =1:size(index_list,2)
  datacount = sum(data(index_list(i),:));
  for j=1:size(data(index_list(i),:),2)
    if(datacount != 0)
      data(index_list(i),j) = data(index_list(i),j) / double(datacount);
    endif
  endfor
endfor

%% Plotting
figure
hold on
pandemic   = plot(data(1,:));  % pandemic
covid19    = plot(data(2,:));  % covid19
coronavirus= plot(data(3,:));  % coronavirus
wuhan      = plot(data(5,:));  % wuhan
wuhanvirus = plot(data(6,:));  % wuhanvirus
chinavirus = plot(data(22,:)); % chinavirus
epidemic   = plot(data(26,:)); % epidemic
fake       = plot(data(39,:)); % fake
cough      = plot(data(45,:)); % cough
ventilators= plot(data(53,:)); % ventilators
masks      = plot(data(55,:)); % masks
sanitizer  = plot(data(77,:)); % sanitizer
toilet     = plot(data(79,:)); % toilet paper

% Change plot properties
set(pandemic,    'Color', [0.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(covid19,     'Color', [0.0 0.0 0.5], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(coronavirus, 'Color', [0.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(wuhan,       'Color', [0.0 0.5 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(wuhanvirus,  'Color', [0.0 0.5 0.5], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(chinavirus,  'Color', [0.0 0.5 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(epidemic,    'Color', [0.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(fake,        'Color', [0.0 1.0 0.5], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(cough,       'Color', [0.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(ventilators, 'Color', [1.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(masks,       'Color', [1.0 0.0 0.5], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(sanitizer,   'Color', [1.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(toilet,      'Color', [1.0 0.5 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])

% Add titles
hTitle = title('Occurence of COVID19 keywords in English tweets');
hXLabel = xlabel('Day Number');
hYLabel = ylabel('Relative frequency of each word');
hText = text(33.7, 0, '0');
hText2 = text(10.6, 0, '0');
hText3 = text(39.6, 0, '0');


% Add legend
hLegend = legend([pandemic,covid19,coronavirus,wuhan,wuhanvirus,chinavirus,epidemic,fake,cough,ventilators,masks,sanitizer,toilet], ...
library{1},library{2},library{3},library{5},library{6},library{22},library{26},library{39},library{45},library{53},library{55},library{77},library{79}, ...
    'Location', 'NorthEast');
 
% Adjust font
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel, hText, hText2], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
set([hText, hText2, hText3], 'FontSize', 13, 'FontWeight' , 'bold')

set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

% Adjust axes properties
xticks([0 10 20 30 40])
xticklabels({'Jan 22','Feb 1','Feb 11','Feb 21','Mar 2'})
%yticks([-1 -0.8 -0.2 0 0.2 0.8 1])

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:500:2500, ...
    'LineWidth', 1)
hold off


%%%%%%%%%%%%%%%%%%%
%%%% Section 2 %%%%
%%%%%%%%%%%%%%%%%%%

library = {'pandemic','covid19','coronavirus','china','wuhan','wuhanvirus','trump','stimulus','economy','health','hospital','hospitals','distancing','social','america','americas','europe','italy','spain','france','germany','chinavirus','racist','shelter','medical','epidemic','pence','stock','market','markets','fauci','conservatives','liberals','democrats','republicans','asian','asia','panic','fake','closure','schools','universities','university','symptoms','cough','lungs','dead','dying','die','recovered','restrictions','recession','ventilators','respiratory','masks','mask','gloves','ppe', 'protective','stayathome','trumpmadness','safehands','viewfrommywindow','mypandemicsurvivalplan','quarantineandchill','flu','usa','corona','students','cdc','canceled','cancelled','crisis','tests','test','god','sanitizer','research','toilet','epicenter','groceries','grocery','war','invisible'};

sect2_data = OGdata;
index_list2 = [3,7,8,9,27,28,29,32,33,39,52,73,83];

%% First, combine market and markets rows, i.e. add together rows 29 and 30 before normalizing.
sect2_data(29,:) = sect2_data(29,:) + sect2_data(30,:);

% Normalize each column by the number of tweets available for that day
for i = 1:size(data_cols,2) 
  if(data_cols(i) > 1000)    % Number of tweets available on a day
    sect2_data(:,i) = sect2_data(:,i)/double(data_cols(i));
  else
    sect2_data(:,i) = zeros(size(sect2_data,1),1);
  endif  
endfor


% This normalizes the tweets so that the sum of each row is 1.  This 
% emphasizes relatively when a word was most relevant
for i =1:size(index_list2,2)
  datacount = sum(sect2_data(index_list2(i),:));
  for j=1:size(sect2_data(index_list2(i),:),2)
    if(datacount != 0)
      sect2_data(index_list2(i),j) = sect2_data(index_list2(i),j) / double(datacount);
    endif
  endfor
endfor

index_list2 = [3,7,8,9,27,28,29,32,33,39,52,73,83];
%% Plotting
figure
hold on
p1   = plot(data(3,:));  % 
p2   = plot(data(7,:));  % 
p3   = plot(data(8,:));  % 
p4   = plot(data(9,:));  % 
p5   = plot(data(27,:)); % 
p6   = plot(data(28,:)); % 
p7   = plot(data(29,:)); % 
p8   = plot(data(32,:)); % 
p9   = plot(data(33,:)); % 
p10  = plot(data(39,:)); % 
p11  = plot(data(52,:)); % 
p12  = plot(data(73,:)); % 
p13  = plot(data(83,:)); % 

% Change plot properties
set(p1 , 'Color', [0.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p2 , 'Color', [0.8 0.8 0.8], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p3 , 'Color', [0.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p4 , 'Color', [0.0 0.5 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p5 , 'Color', [0.0 0.5 0.5], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p6 , 'Color', [0.0 0.5 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p7 , 'Color', [0.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p8 , 'Color', [0.0 1.0 0.5], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p9 , 'Color', [0.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p10, 'Color', [1.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p11, 'Color', [1.0 0.0 0.5], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p12, 'Color', [1.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(p13, 'Color', [1.0 0.5 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])

% Add titles
hTitle = title('Occurence of COVID19 keywords in English tweets');
hXLabel = xlabel('Day Number');
hYLabel = ylabel('Relative frequency of each word');
hText = text(33.7, 0, '0');
hText2 = text(10.6, 0, '0');
hText3 = text(39.6, 0, '0');


% Add legend
hLegend = legend([p1, p2, p3, p4, p5, p6,p7, p8, p9, p10, p11, p12, p13], ...
library{3},library{7},library{8},library{9},library{27},library{28},library{29},library{32},library{33},library{39},library{52},library{73},library{83}, ...
    'Location', 'North');
 
% Adjust font
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel, hText, hText2], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
set([hText, hText2, hText3], 'FontSize', 13, 'FontWeight' , 'bold')

set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

% Adjust axes properties
xticks([0 10 20 30 40])
xticklabels({'Jan 22','Feb 1','Feb 11','Feb 21','Mar 2'})
%yticks([-1 -0.8 -0.2 0 0.2 0.8 1])

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:500:2500, ...
    'LineWidth', 1)
