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
	cout << "OpenCV book" << endl;

	wcout << "Current directory: " << getCurrentDirectory() << endl;

	wcout << "Executable path: " << getExecutablePath() << endl;

	cv::Mat image1 = imread("../resources/castle.bmp");
	cv::Mat image2 = imread("../resources/pattern.png");

	cv::Mat result;

	result.create(image1.size(), image1.type());

	cv::addWeighted(image1, 0.9, image2, 0.3, 0.0, result);

	cv::namedWindow("Image 1");
	cv::imshow("Image 1", image1);

	cv::namedWindow("Image 2");
	cv::imshow("Image 2", image2);

	cv::namedWindow("Image Combined");
	cv::imshow("Image Combined", result);

	cv::waitKey(0);

	return 0;
}