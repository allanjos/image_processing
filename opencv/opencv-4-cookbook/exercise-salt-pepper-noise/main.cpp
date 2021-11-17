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

void salt(cv::Mat image, int n) {
	cout << "salt()" << endl;

	int i, j;

	for (int k = 0; k < n; k++) {
		i = std::rand() % image.cols;
		j = std::rand() % image.rows;

		if (image.type() == CV_8UC1) {
			image.at<uchar>(j, i) = 255;
		}
		else if (image.type() == CV_8UC3) {
			image.at<cv::Vec3b>(j, i)[0] = 255;
			image.at<cv::Vec3b>(j, i)[1] = 255;
			image.at<cv::Vec3b>(j, i)[2] = 255;
		}
	}
}

int main() {
	cout << "OpenCV salt & pepper noise" << endl;

	wcout << "Current directory: " << getCurrentDirectory() << endl;

	wcout << "Executable path: " << getExecutablePath() << endl;

	cv::Mat image = imread("../resources/castle.bmp");

	salt(image, 3000);

	cv::namedWindow("Image");

	cv::imshow("Image", image);

	cv::waitKey(0);

	return 0;
}