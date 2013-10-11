class Loc {
	public:
		int x;
		int y;
		void setX(int x) {
			this->x = x;
		}
};

typedef struct sPoint
{
	int x;
	int y;
} Point;

int main() {
	int *pi;	
	Point p;
	p.x = 1;

	pi++;
	*pi = 10;
	
	Loc* l = new Loc();
	l->setX(10);

	return p.y;
}
