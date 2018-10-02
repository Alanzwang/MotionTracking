clc;
close all;
clear;

% -------------------------------------------------------------------------
% Import data

load PSMotionTrackingData20181001175117.mat
% convert imported data from cell to array
PSData_FrameIdx = cell2mat(RBPointersdataTrial220181001175117(:,1));
PSData_Timestamp = cell2mat(RBPointersdataTrial220181001175117(:,2));
time = PSData_Timestamp - PSData_Timestamp(1); 

% rigid body position
PSData_rbPos = cell2mat(RBPointersdataTrial220181001175117(:,3:5));
% IMPORTANT: remember to reverse the z-axis, as the z coordinate calculated
% in Vizard is the reverse of the z coordinate in PhaseSpace coordinate system
% position 
PSData_rbPos(:,3) = (-1)*PSData_rbPos(:,3);

% rigid body orientation (yaw, pitch, roll)
PSData_rbOri = cell2mat(RBPointersdataTrial220181001175117(:,6:8));

% point tracker #0 position
PSData_pt0Pos = cell2mat(RBPointersdataTrial220181001175117(:,9:11));

% point tracker #1 position
PSData_pt1Pos = cell2mat(RBPointersdataTrial220181001175117(:,12:14));

% point tracker #2 position
PSData_pt2Pos = cell2mat(RBPointersdataTrial220181001175117(:,15:17));

% point tracker #3 position
PSData_pt3Pos = cell2mat(RBPointersdataTrial220181001175117(:,18:20));

% point tracker #4 position
PSData_pt4Pos = cell2mat(RBPointersdataTrial220181001175117(:,21:23));

% point tracker #5 position
PSData_pt5Pos = cell2mat(RBPointersdataTrial220181001175117(:,24:26));

% calculate geometric centre of rigid body
PSData_rbPosCal = (PSData_pt0Pos + PSData_pt1Pos + PSData_pt2Pos + PSData_pt3Pos + PSData_pt4Pos)/5;

% -------------------------------------------------------------------------
% Plot data
% The trajectory of point track #5
figure;
    plot3(PSData_pt5Pos(:,1),PSData_pt5Pos(:,2), PSData_pt5Pos(:,3));
    title('Position of point tracker #5 (reference)');
    xlabel('x');
    ylabel('y');
    zlabel('z');

% relative distance between rigid body and the reference point tracker #5
dist_rb_pt5 = sqrt(sum((PSData_rbPos - PSData_pt5Pos).^(2),2));
% relative distance between rigid body (centre of mass) and the reference point tracker #5
dis_rbCal_pt5 = sqrt(sum((PSData_rbPosCal - PSData_pt5Pos).^(2),2));
figure;
    subplot(2,1,1);
    plot(time,dist_rb_pt5);
    title('relative distance between rigid body (by Recap2) and point track #5');
    xlabel('Time (s)');
    ylabel('Distance (m)');

    subplot(2,1,2);
    plot(time,dis_rbCal_pt5);
    title('relative distance between rigid body (centre of mass) and point track #5');
    xlabel('Time (s)');
    ylabel('Distance (m)');

% The trajectory of rigid body
figure;
    subplot(2,1,1);
    plot3(PSData_rbPos(:,1),PSData_rbPos(:,2), PSData_rbPos(:,3));
    title('Rigid body position (by Recap2)');
    xlabel('x');
    ylabel('y');
    zlabel('z');

    subplot(2,1,2);
    plot3(PSData_rbPosCal(:,1),PSData_rbPosCal(:,2), PSData_rbPosCal(:,3));
    title('Rigid body position (centre of mass)');
    xlabel('x');
    ylabel('y');
    zlabel('z');

% relative distance between point trackers
dist_pt0_pt1 = sqrt(sum((PSData_pt0Pos - PSData_pt1Pos).^(2),2));
dist_pt0_pt2 = sqrt(sum((PSData_pt0Pos - PSData_pt2Pos).^(2),2));
dist_pt0_pt3 = sqrt(sum((PSData_pt0Pos - PSData_pt3Pos).^(2),2));
dist_pt0_pt4 = sqrt(sum((PSData_pt0Pos - PSData_pt4Pos).^(2),2));
dist_pt0_pt5 = sqrt(sum((PSData_pt0Pos - PSData_pt5Pos).^(2),2));

dist_pt1_pt2 = sqrt(sum((PSData_pt1Pos - PSData_pt2Pos).^(2),2));
dist_pt1_pt3 = sqrt(sum((PSData_pt1Pos - PSData_pt3Pos).^(2),2));
dist_pt1_pt4 = sqrt(sum((PSData_pt1Pos - PSData_pt4Pos).^(2),2));
dist_pt1_pt5 = sqrt(sum((PSData_pt1Pos - PSData_pt5Pos).^(2),2));

dist_pt2_pt3 = sqrt(sum((PSData_pt2Pos - PSData_pt3Pos).^(2),2));
dist_pt2_pt4 = sqrt(sum((PSData_pt2Pos - PSData_pt4Pos).^(2),2));
dist_pt2_pt5 = sqrt(sum((PSData_pt2Pos - PSData_pt5Pos).^(2),2));

dist_pt3_pt4 = sqrt(sum((PSData_pt3Pos - PSData_pt4Pos).^(2),2));
dist_pt3_pt5 = sqrt(sum((PSData_pt3Pos - PSData_pt5Pos).^(2),2));

dist_pt4_pt5 = sqrt(sum((PSData_pt4Pos - PSData_pt5Pos).^(2),2));

figure;
    hold on;
    lineStyles = linspecer(15,'sequential');
    plot(time,dist_pt0_pt1,'Color',lineStyles(1,:),'LineWidth',1);
    plot(time,dist_pt0_pt2,'Color',lineStyles(2,:),'LineWidth',1);
    plot(time,dist_pt0_pt3,'Color',lineStyles(3,:),'LineWidth',1);
    plot(time,dist_pt0_pt4,'Color',lineStyles(4,:),'LineWidth',1);
    plot(time,dist_pt0_pt5,'Color',lineStyles(5,:),'LineWidth',1);

    plot(time,dist_pt1_pt2,'Color',lineStyles(6,:),'LineWidth',1);
    plot(time,dist_pt1_pt3,'Color',lineStyles(7,:),'LineWidth',1);
    plot(time,dist_pt1_pt4,'Color',lineStyles(8,:),'LineWidth',1);
    plot(time,dist_pt1_pt5,'Color',lineStyles(9,:),'LineWidth',1);

    plot(time,dist_pt2_pt3,'Color',lineStyles(10,:),'LineWidth',1);
    plot(time,dist_pt2_pt4,'Color',lineStyles(11,:),'LineWidth',1);
    plot(time,dist_pt2_pt5,'Color',lineStyles(12,:),'LineWidth',1);

    plot(time,dist_pt3_pt4,'Color',lineStyles(13,:),'LineWidth',1);
    plot(time,dist_pt3_pt5,'Color',lineStyles(14,:),'LineWidth',1);

    plot(time,dist_pt4_pt5,'Color',lineStyles(15,:),'LineWidth',1);

    xlabel('Time (s)');
    ylabel('Distance (m)');
    legend('pt0--pt1','pt0--pt2','pt0--pt3','pt0--pt4','pt0--pt5',...
        'pt1--pt2','pt1--pt3','pt1--pt4','pt1--pt5',...
        'pt2--pt3','pt2--pt4','pt2--pt5',...
        'pt3--pt4','pt3--pt5','pt4--pt5');
    hold off;

