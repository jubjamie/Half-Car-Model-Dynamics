function [detailX,detailY] = makeCarBody(carX,carY,theta,aspectX)
%MAKECARBODY Create plotting points in cartesian space for the bar body
%   Using gradient maths from the car base.

% Calculate normal gradient
% Base gradient
baseGradient=(carY(2)-carY(1))/(carX(2)-carX(1));
normalGradient=-1/baseGradient;

theta=asin(theta);

%Car base points
%BonnetBack
bonnetBackX=carX(2)+(0.65*(carX(3)-carX(2)));
bonnetBackY=carY(2)+(0.65*(carY(3)-carY(2)));

%Windsheild Top
wsTopX=carX(2)+(0.4*(carX(3)-carX(2)));
wsTopY=carY(2)+(0.4*(carY(3)-carY(2)));

%Boot Front
bootFrontX=carX(1)+(0.2*(carX(2)-carX(1)));
bootFrontY=carY(1)+(0.2*(carY(2)-carY(1)));

% Calculate body points
bootTop=[carX(1),carY(1)]+(0.2.*[-sin(theta)*aspectX,cos(theta)]);
bootFront=[bootFrontX,bootFrontY]+(0.2.*[-sin(theta),cos(theta)]);
bonnetFront=[carX(3),carY(3)]+(0.15.*[-sin(theta)*aspectX,cos(theta)]);
bonnetBack=[bonnetBackX,bonnetBackY]+(0.18.*[-sin(theta)*aspectX,cos(theta)]);
wsTop=[wsTopX,wsTopY]+(0.35.*[-sin(theta)*aspectX,cos(theta)]);
peakTop=[carX(2),carY(2)]+(0.42.*[-sin(theta)*aspectX,cos(theta)]);


detailX=[carX(1),bootTop(1),bootFront(1),peakTop(1),wsTop(1),bonnetBack(1),bonnetFront(1),carX(3)];
detailY=[carY(1),bootTop(2),bootFront(2),peakTop(2),wsTop(2),bonnetBack(2),bonnetFront(2),carY(3)];
end

