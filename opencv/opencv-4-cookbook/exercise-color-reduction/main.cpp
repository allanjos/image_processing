#include <cstdio>
#include <iostream>

#include <windows.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

#define MAX_DIR_PATH 2048

using namespace std;
using namespace cv;

wstring getCurrentDirectory() {
	TCHAR buffer[MAX_DIR_PATH] = { 0 };

	GetCurrentDirectory(MAX_DIR_PATH, buffer);

	return std::wstring(buffer);
}

wstring getExecutablePath() {
	TCHAR buffer[MAX_DIR_PATH] = { 0 };

	GetModuleFileName(NULL, buffer, MAX_PATH);

	std::wstring::size_type pos = std::wstring(buffer).find_last_of(L"\\/");

	return std::wstring(buffer).substr(0, pos);
}

void colorReduce(cv::Mat image, int factor=64) {
	cout << "salt()" << endl;

	for (int j = 0; j < image.rows; j++) {
		if (image.type() == CV_8UC1) {
			uchar* data = image.ptr<uchar>(j);

			for (int i = 0; i < image.cols; i++) {
				data[i] = data[i] / factor * factor + factor / 2;
			}
		}
		else if (image.type() == CV_8UC3) {
			Vec3b* data = image.ptr<Vec3b>(j);

			for (int i = 0; i < image.cols; i++) {
				data[i][0] = data[i][0] / factor * factor + factor / 2;
				data[i][1] = data[i][1] / factor * factor + factor / 2;
				data[i][2] = data[i][2] / factor * factor + factor / 2;
			}
		}
	}
}

int main() {
	cout << "OpenCV color reduction" << endl;

	wcout << "Current directory: " << getCurrentDirectory() << endl;

	wcout << "Executable path: " << getExecutablePath() << endl;

	cv::Mat image = imread("../resources/castle.bmp");

	colorReduce(image, 64);

	cv::namedWindow("Image");

	cv::imshow("Image", image);

	cv::waitKey(0);

	return 0;
}