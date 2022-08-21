float(float minimum,float maximum) RandomRange =
{
    return random() * (maximum - minimum) + minimum;
}

float(float a, float b, float t) lerp =
{
	return a * (1 - t) + b * t;
}