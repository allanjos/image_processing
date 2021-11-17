#include <cstdio>
#include <iostream>

#include <windows.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc.hpp>

using namespace std;
using namespace cv;

wstring getExecutablePath() {
	TCHAR buffer[MAX_PATH] = { 0 };

	GetModuleFileName(NULL, buffer, MAX_PATH);

	std::wstring::size_type pos = std::wstring(buffer).find_last_of(L"\\/");

	return std::wstring(buffer).substr(0, pos);
}

void onMouse(int event, int x, int y, int flags, void *param) {
	cout << "onMouse() " << endl;

	cv::Mat *image = reinterpret_cast<cv::Mat *>(param);

	switch (event) {
	case cv::EVENT_LBUTTONDOWN:
		cout << "Left mouse button click at (" << x << "," << y << ") img point value: " << static_cast<int>(image->at<uchar>(Point(x, y))) << endl;
		break;
	}
}

int main() {
	cout << "OpenCV draw, mouse event, flip" << endl;

	wcout << "Executable path: " << getExecutablePath() << endl;

	cv::Mat image;

	cout << "This image is << " << image.rows << " x " << image.cols << endl;

	string imagePath = "../resources/neptune.bmp";

	image = cv::imread(imagePath);

	if (image.empty()) {
		cout << "Error on trying to open " << imagePath << endl;

		return 1;
	}

	// Draw a circle

	cv::Point centerCircle1(50, 50);
	int radiusCircle = 10;
	cv::Scalar colorCircle1(0, 0, 255);
	int thicknessCircle1 = 2;

	cv::circle(image, centerCircle1, radiusCircle, colorCircle1, thicknessCircle1);

	// Draw text

	cv::putText(image, "Point", cv::Point(70, 50), cv::FONT_HERSHEY_PLAIN, 1.0, 255, 2);

	// Flip image

	cv::Mat imageFlipped;

	cv::flip(image, imageFlipped, 1);

	// Show original image

	cv::imshow("Image", image);

	// Set mouse callback

	cv::setMouseCallback("Image", onMouse, reinterpret_cast<void*>(&image));

	// Show flipped image

	cv::imshow("Flipped image", imageFlipped);

	cv::imwrite("output.bmp", imageFlipped);

	cv::waitKey(0);

	return 0;
}