public function get_remote_posts() {
	$posts = get_transient( 'remote_posts' );
	if( empty( $posts ) ) {
		$response = wp_remote_get( 'http://mysite.com/wp-json/wp/v2/posts/' );
		if( is_wp_error( $response ) ) {
			return array();
		}

		$posts = json_decode( wp_remote_retrieve_body( $response ) );

		if( empty( $posts ) ) {
			return array();
		}

		set_transient( 'remote_posts', $posts, HOUR_IN_SECONDS );
	}

	return $posts;
}


public function widget( $args, $instance ) {
	$posts = $this->get_remote_posts();

	if( empty( $posts ) ) {
		return;
	}

    echo $args['before_widget'];

	if( !empty( $instance['title'] ) ) {
		echo $args['before_title'] . apply_filters( 'widget_title', $instance['title'], $instance, $this->id_base ) . $args['after_title'];
	}

	echo '<ul>';
	foreach( $posts as $post ) {
		echo '<li><a href="' . $post->link. '">' . $post->title->rendered . '</a></li>';
	}
	echo '</ul>';

	echo $args['after_widget'];

}
