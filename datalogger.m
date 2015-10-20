function datalogger

% datalogger is a UI you can use to input your fitness data for the day!
%       stores all data to an array under the current date.
%       
%       when you open the UI it will check the array and if anything has
%       already been entered for the current date then it will populate
%       that field for you. this way you can open the UI multiple times per
%       day.

%% Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[100,100,750,500]);

%% Construct the components
% Choose editor style
hstyle = uicontrol('Style','text','String','Select Editor Style',...
    'Units','pixels','Position',[300,450,120,15]);
bstyle = uibuttongroup('Visible','off','Units','pixels',...
    'Position',[hstyle.Position(1),hstyle.Position(2)-35,hstyle.Position(3),35],...
    'SelectionChangedFcn',@bselection); % bselection will reconstruct the 
                                    % UI for basic vs. advanced editor
                                    % style
                                    %[0.7 0.19 0.2 0.125]
rstyle1 = uicontrol(bstyle,'Style','radiobutton','String','Basic',...
    'Position',[0 0 120 15],'HandleVisibility','on');
rstyle2 = uicontrol(bstyle,'Style','radiobutton','String','Advanced',...
    'Position',[0 15 120 15],'HandleVisibility','on');
bstyle.Visible = 'on';

% Enter your weight for today
% In advanced version this will have waking weight, pre-training,
% post-training weights to enter
hwtxt = uicontrol('Style','text','String','Body Weight',...
    'Units','pixels','Position',[300,90,120,15]);
hweight = uicontrol('Style','edit','String','Weight',...
    'Position',[hwtxt.Position(1),hwtxt.Position(2)-25,hwtxt.Position(3),25]);



ha = axes('Units','pixels','Position',[50,60,200,185]);


% Make the UI visible
f.Visible = 'on';
end
