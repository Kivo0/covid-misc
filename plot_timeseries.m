%% Thomas Merkh, tmerkh@g.ucla.edu
%% This script loads in the time series matrices formed using the Create_Matrix.py script.
%% Essentially, all that is being done here is plotting different aspects of these time series on linear and log scales
%% This file was written for Octave 4.4.1 

pkg load statistics
pkg load optim

load('TimeSeriesMatrices/recoveredglobal.mat')
load('TimeSeriesMatrices/deathsglobal.mat')
load('TimeSeriesMatrices/confirmedglobal.mat')
load('TimeSeriesMatrices/deathsUSA.mat')
load('TimeSeriesMatrices/confirmedUSA.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Global %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = confirmedglobal;

%china
chinadata = data(51,:);
for i=51:83
  chinadata = chinadata + data(i,:);
endfor

%uk
ukdata = data(219,:);
for i=220:225
  ukdata = ukdata + data(i,:);
endfor

figure
hold on;
% Need to add 1 compare to the confirmed_row_infor_global line number!
usa      = plot(data(227,:)); % USA
uk       = plot(ukdata); % UK
italy    = plot(data(139,:)); % Italy
iran     = plot(data(135,:)); % Iran
germany  = plot(data(122,:)); % Germany
china    = plot(chinadata);   % China
set(usa    , 'Color', [0.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(uk     , 'Color', [0.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(italy  , 'Color', [0.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(iran   , 'Color', [0.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(germany, 'Color', [1.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(china  , 'Color', [1.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])


% Add titles
hTitle = title('Confirmed Cases at Select Countries');
hXLabel = xlabel('Day Number');
hYLabel = ylabel('Counts');
%hText = text(33.7, 0, '0');
%hText2 = text(10.6, 0, '0');
%hText3 = text(39.6, 0, '0');


% Add legend
hLegend = legend([usa,uk,italy,iran,germany,china], ...
'usa','uk','italy','iran','germany','china', 'Location', 'NorthWest');


% Adjust font
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
%set([hText, hText2, hText3], 'FontSize', 13, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')


% Adjust axes properties
xticks([0 10 20 30 40 50 60 70])
xticklabels({'Jan 22','Feb 1','Feb 11','Feb 21','Mar 2','Mar 12','Mar 22','Apr 1'})

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:25000:300000, ...
    'LineWidth', 1)
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% USA %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = confirmedUSA;
%data = log(confirmedUSA);

la       = data(211,:) ;
nyc      = data(1865,:);
pa       = data(2301,:);
houston  = data(2642,:);
sf       = data(230,:) ;
sd       = data(229,:) ;
denver   = data(267,:) ;
miami    = data(369,:) ;
seattle  = data(2976,:);

figure
hold on;
% Need to add 1 compared to the confirmed_row_info_USA line number!
LA       = plot(la     ); 
NYC      = plot(nyc    ); 
PA       = plot(pa     ); 
Houston  = plot(houston); 
SF       = plot(sf     );
SD       = plot(sd     );
Denver   = plot(denver );
Miami    = plot(miami  );
Seattle  = plot(seattle);

set(LA     , 'Color', [0.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(NYC    , 'Color', [0.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(PA     , 'Color', [0.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(Houston, 'Color', [0.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(SF     , 'Color', [1.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(SD     , 'Color', [1.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(Denver , 'Color', [1.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(Miami  , 'Color', [0.3 0.3 0.3], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])
set(Seattle, 'Color', [0.1 0.8 0.3], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7])


% Add titles
hTitle = title('Confirmed Cases at Select US Cities');
hXLabel = xlabel('Day');
hYLabel = ylabel('Counts');
%hText = text(33.7, 0, '0');
%hText2 = text(10.6, 0, '0');
%hText3 = text(39.6, 0, '0');


% Add legend
hLegend = legend([LA,NYC,PA,Houston,SF,SD,Denver,Miami,Seattle], ...
'LA', 'NYC', 'Phila', 'Houston TX', 'SF', 'SD','Denver','Miami','Seattle', 'Location', 'NorthWest');

% Adjust font
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
%set([hText, hText2, hText3], 'FontSize', 13, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

% Adjust axes properties
xticks([0 10 20 30 40 50 60 70])
xticklabels({'Jan 22','Feb 1','Feb 11','Feb 21','Mar 2','Mar 12','Mar 22','Apr 1'})

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:5000:300000, ...
    'LineWidth', 1)

hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Best fit line on log scale %%%%%%%%%%%%
%%%%%%%%%%% Best fit exp on linear scale %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s_la      = la(45:end);
s_nyc     = nyc(45:end);     
s_pa      = pa(45:end);      
s_houston = houston(45:end); 
s_sf      = sf(45:end);      
s_sd      = sd(45:end);      
s_denver  = denver(45:end);  
s_miami   = miami(45:end);   
s_seattle = seattle(45:end); 

ls_la      = log(la(45:end));
ls_nyc     = log(nyc(45:end));     
ls_pa      = log(pa(45:end));      
ls_houston = log(houston(45:end)); 
ls_sf      = log(sf(45:end));      
ls_sd      = log(sd(45:end));      
ls_denver  = log(denver(45:end));  
ls_miami   = log(miami(45:end));   
ls_seattle = log(seattle(45:end)); 

x = linspace(1,size(ls_la,2),size(ls_la,2));

% A linear fit in log scale
c1  = polyfit(x,ls_la,1);     
c2  = polyfit(x,ls_nyc,1);    
c3  = polyfit(x,ls_pa,1);     
c4  = polyfit(x,ls_houston,1);
c5  = polyfit(x,ls_sf,1);     
c6  = polyfit(x,ls_sd,1);     
c7  = polyfit(x,ls_denver,1); 
c8  = polyfit(x,ls_miami,1);  
c10 = polyfit(x,ls_seattle,1);

% An exponential fit in regular scale
[rate1,coeff1,rms1] = expfit(1,1,1,s_la);     
[rate2,coeff2,rms2] = expfit(1,1,1,s_nyc);    
[rate3,coeff3,rms3] = expfit(1,1,1,s_pa);     
[rate4,coeff4,rms4] = expfit(1,1,1,s_houston);
[rate5,coeff5,rms5] = expfit(1,1,1,s_sf);     
[rate6,coeff6,rms6] = expfit(1,1,1,s_sd);     
[rate7,coeff7,rms7] = expfit(1,1,1,s_denver); 
[rate8,coeff8,rms8] = expfit(1,1,1,s_miami);  
[rate10,coeff10,rms10] = expfit(1,1,1,s_seattle);

% How an exponential fit looks in ordinary scale
xest_s_la      = coeff1*exp(rate1.*x);
xest_s_nyc     = coeff2*exp(rate2.*x);
xest_s_pa      = coeff3*exp(rate3.*x);
xest_s_houston = coeff4*exp(rate4.*x);
xest_s_sf      = coeff5*exp(rate5.*x);
xest_s_sd      = coeff6*exp(rate6.*x);
xest_s_denver  = coeff7*exp(rate7.*x);
xest_s_miami   = coeff8*exp(rate8.*x);
xest_s_seattle = coeff10*exp(rate10.*x);

% How the linear fit in log scale looks in log scale
est_ls_la      = polyval(c1,x);
est_ls_nyc     = polyval(c2,x);
est_ls_pa      = polyval(c3,x);
est_ls_houston = polyval(c4,x);
est_ls_sf      = polyval(c5,x);
est_ls_sd      = polyval(c6,x);
est_ls_denver  = polyval(c7,x);
est_ls_miami   = polyval(c8,x);
est_ls_seattle = polyval(c10,x);


% How a linear fit on log scale translates to ordinary scales
est_s_la      = exp((c1(1).*x + c1(2)));
est_s_nyc     = exp((c2(1).*x + c2(2)));
est_s_pa      = exp((c3(1).*x + c3(2)));
est_s_houston = exp((c4(1).*x + c4(2)));
est_s_sf      = exp((c5(1).*x + c5(2)));
est_s_sd      = exp((c6(1).*x + c6(2)));
est_s_denver  = exp((c7(1).*x + c7(2)));
est_s_miami   = exp((c8(1).*x + c8(2)));
est_s_seattle = exp((c10(1).*x + c10(2)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Plot the Fits %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% How the linear fit looks on log scale
figure
hold on;

% True data points
LA       = plot(x,ls_la     ); 
NYC      = plot(x,ls_nyc    ); 
PA       = plot(x,ls_pa     ); 
Houston  = plot(x,ls_houston); 
SF       = plot(x,ls_sf     );
SD       = plot(x,ls_sd     );
Denver   = plot(x,ls_denver );
Miami    = plot(x,ls_miami  );
Seattle  = plot(x,ls_seattle);

% Fitted Data points 
lLA       = plot(x,est_ls_la); 
lNYC      = plot(x,est_ls_nyc); 
lPA       = plot(x,est_ls_pa); 
lHouston  = plot(x,est_ls_houston); 
lSF       = plot(x,est_ls_sf);
lSD       = plot(x,est_ls_sd);
lDenver   = plot(x,est_ls_denver);
lMiami    = plot(x,est_ls_miami);
lSeattle  = plot(x,est_ls_seattle);


set(LA     , 'Color', [0.0 0.0 0.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])
set(NYC    , 'Color', [0.0 0.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
set(PA     , 'Color', [0.0 1.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 1.0], 'MarkerFaceColor' , [0.0 1.0 1.0])
set(Houston, 'Color', [0.0 1.0 0.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 0.0], 'MarkerFaceColor' , [0.0 1.0 0.0])
set(SF     , 'Color', [1.0 1.0 0.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 0.0], 'MarkerFaceColor' , [1.0 1.0 0.0])
set(SD     , 'Color', [1.0 1.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 1.0], 'MarkerFaceColor' , [1.0 1.0 1.0])
set(Denver , 'Color', [1.0 0.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 0.0 1.0], 'MarkerFaceColor' , [1.0 0.0 1.0])
set(Miami  , 'Color', [0.3 0.3 0.3], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.3 0.3 0.3], 'MarkerFaceColor' , [0.3 0.3 0.3])
set(Seattle, 'Color', [0.1 0.8 0.3], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.1 0.8 0.3], 'MarkerFaceColor' , [0.1 0.8 0.3])

set(lLA     , 'Color', [0.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])
set(lNYC    , 'Color', [0.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
set(lPA     , 'Color', [0.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 1.0], 'MarkerFaceColor' , [0.0 1.0 1.0])
set(lHouston, 'Color', [0.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 0.0], 'MarkerFaceColor' , [0.0 1.0 0.0])
set(lSF     , 'Color', [1.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 0.0], 'MarkerFaceColor' , [1.0 1.0 0.0])
set(lSD     , 'Color', [1.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 1.0], 'MarkerFaceColor' , [1.0 1.0 1.0])
set(lDenver , 'Color', [1.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 0.0 1.0], 'MarkerFaceColor' , [1.0 0.0 1.0])
set(lMiami  , 'Color', [0.3 0.3 0.3], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.3 0.3 0.3], 'MarkerFaceColor' , [0.3 0.3 0.3])
set(lSeattle, 'Color', [0.1 0.8 0.3], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.1 0.8 0.3], 'MarkerFaceColor' , [0.1 0.8 0.3])


hTitle = title('Linear Fitting on Log Scale');
hXLabel = xlabel('Day');
hYLabel = ylabel('ln(Counts)');
hLegend = legend([LA,NYC,PA,Houston,SF,SD,Denver,Miami,Seattle], ...
'LA', 'NYC', 'Phila', 'Houston TX', 'SF', 'SD','Denver','Miami','Seattle', 'Location', 'NorthWest');

set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

xticks([0 10 20 30])
xticklabels({'Mar 8','Mar 18','March 28','Apr 7'})

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:5000:300000, ...
    'LineWidth', 1)

hold off


%%%% How the linear fit log plot translates back to linear scale - only NYC
figure
hold on;

% True data points
NYC      = plot(x,s_nyc); 
lNYC     = plot(x,est_s_nyc); 
xNYC     = plot(x,xest_s_nyc);
set(NYC    , 'Color', [0.0 0.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'o', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
set(lNYC   , 'Color', [0.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
set(xNYC   , 'Color', [0.0 0.0 1.0], 'LineStyle', '-.','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
 
hLegend = legend([NYC, lNYC,xNYC], ...
'True Data', 'Linear Fit', 'Exp Fit', 'Location', 'NorthWest');
	
hTitle = title('Different Methods of Fitting: New York');
hXLabel = xlabel('Day');
hYLabel = ylabel('Counts');

set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
%set([hText, hText2, hText3], 'FontSize', 13, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

xticks([0 10 20 30])
xticklabels({'Mar 8','Mar 18','March 28','Apr 7'})

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:20000:400000, ...
    'LineWidth', 1)

hold off


%%%%%%%%%%%%%%%%% Los Angeles Now %%%%%%%%%%%%%%%%%%
figure
hold on;

% True data points
LA      = plot(x,s_la); 
lLA     = plot(x,est_s_la); 
xLA     = plot(x,xest_s_la);
set(LA    , 'Color', [0.0 0.0 0.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'o', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])
set(lLA   , 'Color', [0.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])
set(xLA   , 'Color', [0.0 0.0 0.0], 'LineStyle', '-.','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])


hLegend = legend([LA, lLA,xLA], ...
'True Data', 'Linear Fit', 'Exp Fit', 'Location', 'NorthWest');
	
hTitle = title('Different Methods of Fitting: Los Angeles');
hXLabel = xlabel('Day');
hYLabel = ylabel('Counts');

set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
%set([hText, hText2, hText3], 'FontSize', 13, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

xticks([0 10 20 30])
xticklabels({'Mar 8','Mar 18','March 28','Apr 7'})

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:1000:400000, ...
    'LineWidth', 1)

hold off

%%%  How the linear fit translates back for the other cities
figure
hold on;

% True data points
LA       = plot(x,s_la     ); 
%NYC      = plot(x,s_nyc    ); 
PA       = plot(x,s_pa     ); 
Houston  = plot(x,s_houston); 
SF       = plot(x,s_sf     );
SD       = plot(x,s_sd     );
Denver   = plot(x,s_denver );
Miami    = plot(x,s_miami  );
Seattle  = plot(x,s_seattle);

% Lin Fit
lLA       = plot(x,est_s_la); 
%lNYC      = plot(x,est_s_nyc); 
lPA       = plot(x,est_s_pa); 
lHouston  = plot(x,est_s_houston); 
lSF       = plot(x,est_s_sf);
lSD       = plot(x,est_s_sd);
lDenver   = plot(x,est_s_denver);
lMiami    = plot(x,est_s_miami);
lSeattle  = plot(x,est_s_seattle);

% Exp fit
xLA       = plot(x,xest_s_la); 
%xNYC      = plot(x,xest_s_nyc); 
xPA       = plot(x,xest_s_pa); 
xHouston  = plot(x,xest_s_houston); 
xSF       = plot(x,xest_s_sf);
xSD       = plot(x,xest_s_sd);
xDenver   = plot(x,xest_s_denver);
xMiami    = plot(x,xest_s_miami);
xSeattle  = plot(x,xest_s_seattle);

set(LA     , 'Color', [0.0 0.0 0.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])
%set(NYC    , 'Color', [0.0 0.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
set(PA     , 'Color', [0.0 1.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 1.0], 'MarkerFaceColor' , [0.0 1.0 1.0])
set(Houston, 'Color', [0.0 1.0 0.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 0.0], 'MarkerFaceColor' , [0.0 1.0 0.0])
set(SF     , 'Color', [1.0 1.0 0.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 0.0], 'MarkerFaceColor' , [1.0 1.0 0.0])
set(SD     , 'Color', [1.0 1.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 1.0], 'MarkerFaceColor' , [1.0 1.0 1.0])
set(Denver , 'Color', [1.0 0.0 1.0], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 0.0 1.0], 'MarkerFaceColor' , [1.0 0.0 1.0])
set(Miami  , 'Color', [0.3 0.3 0.3], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.3 0.3 0.3], 'MarkerFaceColor' , [0.3 0.3 0.3])
set(Seattle, 'Color', [0.1 0.8 0.3], 'LineStyle', 'none','LineWidth', 3, 'Marker', 'x', 'MarkerSize', 6, 'MarkerEdgeColor', [0.1 0.8 0.3], 'MarkerFaceColor' , [0.1 0.8 0.3])

set(lLA     , 'Color', [0.0 0.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])
%set(lNYC    , 'Color', [0.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
set(lPA     , 'Color', [0.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 1.0], 'MarkerFaceColor' , [0.0 1.0 1.0])
set(lHouston, 'Color', [0.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 0.0], 'MarkerFaceColor' , [0.0 1.0 0.0])
set(lSF     , 'Color', [1.0 1.0 0.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 0.0], 'MarkerFaceColor' , [1.0 1.0 0.0])
set(lSD     , 'Color', [1.0 1.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 1.0], 'MarkerFaceColor' , [1.0 1.0 1.0])
set(lDenver , 'Color', [1.0 0.0 1.0], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 0.0 1.0], 'MarkerFaceColor' , [1.0 0.0 1.0])
set(lMiami  , 'Color', [0.3 0.3 0.3], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.3 0.3 0.3], 'MarkerFaceColor' , [0.3 0.3 0.3])
set(lSeattle, 'Color', [0.1 0.8 0.3], 'LineStyle', '-','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.1 0.8 0.3], 'MarkerFaceColor' , [0.1 0.8 0.3])

set(xLA     , 'Color', [0.0 0.0 0.0], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 0.0], 'MarkerFaceColor' , [0.0 0.0 0.0])
set(xNYC    , 'Color', [0.0 0.0 1.0], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 0.0 1.0], 'MarkerFaceColor' , [0.0 0.0 1.0])
set(xPA     , 'Color', [0.0 1.0 1.0], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 1.0], 'MarkerFaceColor' , [0.0 1.0 1.0])
set(xHouston, 'Color', [0.0 1.0 0.0], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.0 1.0 0.0], 'MarkerFaceColor' , [0.0 1.0 0.0])
set(xSF     , 'Color', [1.0 1.0 0.0], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 0.0], 'MarkerFaceColor' , [1.0 1.0 0.0])
set(xSD     , 'Color', [1.0 1.0 1.0], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 1.0 1.0], 'MarkerFaceColor' , [1.0 1.0 1.0])
set(xDenver , 'Color', [1.0 0.0 1.0], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [1.0 0.0 1.0], 'MarkerFaceColor' , [1.0 0.0 1.0])
set(xMiami  , 'Color', [0.3 0.3 0.3], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.3 0.3 0.3], 'MarkerFaceColor' , [0.3 0.3 0.3])
set(xSeattle, 'Color', [0.1 0.8 0.3], 'LineStyle', ':','LineWidth', 3, 'Marker', 'none', 'MarkerSize', 6, 'MarkerEdgeColor', [0.1 0.8 0.3], 'MarkerFaceColor' , [0.1 0.8 0.3])

hTitle = title('How The Linear Fit Compares To Exp Fit');
hXLabel = xlabel('Day');
hYLabel = ylabel('Counts');
%hText = text(33.7, 0, '0');
%hText2 = text(10.6, 0, '0');
%hText3 = text(39.6, 0, '0');

hLegend = legend([LA,PA,Houston,SF,SD,Denver,Miami,Seattle], ...
'LA', 'Phila', 'Houston TX', 'SF', 'SD','Denver','Miami','Seattle', 'Location', 'NorthWest');

set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde')
set([hLegend, gca], 'FontSize', 10)
set([hXLabel, hYLabel], 'FontSize', 10, 'FontWeight' , 'bold')
%set([hText, hText2, hText3], 'FontSize', 13, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')

xticks([0 10 20 30])
xticklabels({'Mar 8','Mar 18','March 28','Apr 7'})

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'YTick', 0:1000:400000, ...
    'LineWidth', 1)

hold off

disp('Program Finished')