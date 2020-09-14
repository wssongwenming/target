package com.mmall.util;

import java.util.ArrayList;
import java.util.List;

public class InPolygonTest {
	/**
	 * 判断点是否在多边形内
	 * @param point 检测点
	 * @param pts   多边形的顶点
	 * @return      点在多边形内返回true,否则返回false
	 */
	public static boolean IsPtInPoly(Point2D point, List<Point2D> pts){

		int N = pts.size();
		boolean boundOrVertex = true; //如果点位于多边形的顶点或边上，也算做点在多边形内，直接返回true
		int intersectCount = 0;//cross points count of x
		double precision = 2e-10; //浮点类型计算时候与0比较时候的容差
		Point2D p1, p2;//neighbour bound vertices
		Point2D p = point; //当前点

		p1 = pts.get(0);//left vertex
		for(int i = 1; i <= N; ++i){//check all rays
			if(p.equals(p1)){
				return boundOrVertex;//p is an vertex
			}

			p2 = pts.get(i % N);//right vertex
			if(p.x < Math.min(p1.x, p2.x) || p.x > Math.max(p1.x, p2.x)){//ray is outside of our interests
				p1 = p2;
				continue;//next ray left point
			}

			if(p.x > Math.min(p1.x, p2.x) && p.x < Math.max(p1.x, p2.x)){//ray is crossing over by the algorithm (common part of)
				if(p.y <= Math.max(p1.y, p2.y)){//x is before of ray
					if(p1.x == p2.x && p.y >= Math.min(p1.y, p2.y)){//overlies on a horizontal ray
						return boundOrVertex;
					}

					if(p1.y == p2.y){//ray is vertical
						if(p1.y == p.y){//overlies on a vertical ray
							return boundOrVertex;
						}else{//before ray
							++intersectCount;
						}
					}else{//cross point on the left side
						double xinters = (p.x - p1.x) * (p2.y - p1.y) / (p2.x - p1.x) + p1.y;//cross point of y
						if(Math.abs(p.y - xinters) < precision){//overlies on a ray
							return boundOrVertex;
						}

						if(p.y < xinters){//before ray
							++intersectCount;
						}
					}
				}
			}else{//special case when ray is crossing through the vertex
				if(p.x == p2.x && p.y <= p2.y){//p crossing over p2
					Point2D p3 = pts.get((i+1) % N); //next vertex
					if(p.x >= Math.min(p1.x, p3.x) && p.x <= Math.max(p1.x, p3.x)){//p.x lies between p1.x & p3.x
						++intersectCount;
					}else{
						intersectCount += 2;
					}
				}
			}
			p1 = p2;//next ray left point
		}

		if(intersectCount % 2 == 0){//偶数在多边形外
			return false;
		} else { //奇数在多边形内
			return true;
		}

	}


	/**
	 * 判断是否在圆形内
	 * @param p
	 * @param c
	 * @return
	 */
	public static String distencePC(Point2D p,Circle c){//判断点与圆心之间的距离和圆半径的关系
		String s ;
		double d2 = Math.hypot( (p.getX() - c.getCC().getX() ), (p.getY() - c.getCC().getY()) );
		System.out.println("d2=="+d2);
		double r = c.getR();
		if(d2 > r){
			s = "圆外";
		}else if(d2 < r){
			s = "圆内";
		}else{
			s = "圆上";
		}
		return s;
	}

	public static void main(String[] args){

		Point2D point = new Point2D(3,0.1);
		List<Point2D> pts = new ArrayList<Point2D>();
		pts.add(new Point2D(0, 0));
		pts.add(new Point2D(1, 2));
		pts.add(new Point2D(1.5,1));
		pts.add(new Point2D(2, 2));
		pts.add(new Point2D(2, 1));
		pts.add(new Point2D(3, 0));


		if(IsPtInPoly(point, pts)){
			System.out.println("点在多边形内");
		}else{
			System.out.println("点在多边形外");
		}

		// 测试一个点是否在圆形内
		Point2D centerPoint = new Point2D(116.404172, 39.916605);
		Circle c = new Circle();
		c.setCC(centerPoint);
		c.setR(0.005);//500米
		String s = distencePC(point,c);
		System.out.println("点是否在圆内："+s);

	}

}
